import { User } from '../shared/types';
import { OkPacket, RowDataPacket } from 'mysql2';
import { conn } from '../lib/db';
import { AnySchema, object, string } from 'yup';
import bcrypt from 'bcrypt';

export const userSchema = object<Record<keyof User, AnySchema>>().shape({
  firstName: string().required(),
  lastName: string().required(),
  email: string().email().required(),
  password: string().required(),
});

export enum UserQueries {
  CREATE = 'INSERT INTO user (id, firstName, lastName, email, password) VALUES (?, ?, ?, ?, ?)',
  UPDATE = 'UPDATE user SET firstName = ?, lastName = ?, password = ?, role = ? WHERE id = ?',
  GET_BY_ID = 'SELECT * FROM user WHERE id = ?',
  GET_BY_EMAIL = 'SELECT * FROM user WHERE email = ?',
}

/**
 * Creates a new user in the database
 *
 * @param {User} user User the be created
 * @returns {Promise<number>} Promise which resolves to the result of the query
 */
export async function createUser(user: User): Promise<number> {
  const sql = UserQueries.CREATE;

  const salt = bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(user.password, salt);

  return new Promise((resolve, reject) => {
    conn.query(
      sql,
      [user.id, user.firstName, user.lastName, user.email, hash],
      (err, result) => {
        if (err) {
          return reject(err);
        }

        resolve((result as OkPacket).insertId);
      }
    );
  });
}

/**
 * Updates a user in the database
 *
 * @param {User} user User to be updated
 * @returns {Promise<number>} Promise which resolves to the result of the query
 */
export async function updateUser(user: User): Promise<number> {
  const sql = UserQueries.UPDATE;

  const salt = bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(user.password, salt);

  return new Promise((resolve, reject) => {
    conn.query(
      sql,
      [user.firstName, user.lastName, hash, user.role, user.id],
      (err, result) => {
        if (err) {
          return reject(err);
        }

        resolve((result as OkPacket).affectedRows);
      }
    );
  });
}

/**
 * Gets a user
 *
 * @param {string} sql SQL query
 * @param {Array | string | number} params Query parameters
 * @returns {Promise<User>} Promise which resolves to the result of the query
 */
export async function getUser(
  sql: string,
  params: Array<string | number> | string | number
): Promise<User | undefined> {
  return new Promise((resolve, reject) => {
    conn.query(sql, params, (err, result) => {
      if (err) {
        return reject(err);
      }

      const row = (<RowDataPacket>result)[0];
      if (!row) {
        return resolve(undefined);
      }

      resolve({
        id: row.id,
        firstName: row.firstName,
        lastName: row.lastName,
        email: row.email,
        password: row.password,
        role: row.role,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      });
    });
  });
}
