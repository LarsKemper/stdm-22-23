CREATE TABLE IF NOT EXISTS user
  (
     id        INT auto_increment PRIMARY KEY,
     firstName VARCHAR(50) NOT NULL,
     lastName  VARCHAR(50) NOT NULL,
     email     VARCHAR(255) UNIQUE NOT NULL,
     password  VARCHAR(255) NOT NULL,
     role      ENUM('ADMIN', 'USER') NOT NULL DEFAULT 'USER',
     createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
     updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
  );

  CREATE TABLE IF NOT EXISTS league
  (
     id             INT auto_increment PRIMARY KEY,
     name           VARCHAR(50) NOT NULL,
  );

  CREATE TABLE IF NOT EXISTS team
  (
     id             INT auto_increment PRIMARY KEY,
     name           VARCHAR(50) NOT NULL,
     clubId         INT,
     leagueId       INT,
     createdAt      TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
     updatedAt      TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
     FOREIGN KEY(clubId) REFERENCES club(id),
     FOREIGN KEY(leagueId) REFERENCES league(id)
  );

  CREATE TABLE IF NOT EXISTS club
  (
     id             INT auto_increment PRIMARY KEY,
     name           VARCHAR(50) NOT NULL,
     logoUrl        VARCHAR(255) NOT NULL,
     websiteUrl     VARCHAR(255) NOT NULL,
     primaryColor   VARCHAR(7) NOT NULL,
     secondaryColor VARCHAR(7) NOT NULL,
     stadium        VARCHAR(50) NOT NULL,
     address        VARCHAR(255) NOT NULL,
     city           VARCHAR(50) NOT NULL,
     website        VARCHAR(255),
     logoUrl        VARCHAR(255) NOT NULL
  );

CREATE TABLE IF NOT EXISTS player
  (
     id        INT auto_increment PRIMARY KEY,
     teamId    INT NOT NULL,
     countryId INT NOT NULL,
     positon   VARCHAR(50) NOT NULL,
     number    INT NOT NULL,
     height    INT NOT NULL,
     weight    INT NOT NULL,
     birthDate DATE NOT NULL,
     avatarUrl VARCHAR(255) NOT NULL,
     FOREIGN KEY(teamId) REFERENCES teams(id),
     FOREIGN KEY(countryId) REFERENCES countries(id)
  );

  CREATE TABLE IF NOT EXISTS country
  (
     id      INT auto_increment PRIMARY KEY,
     name    VARCHAR(50) NOT NULL,
     iso     VARCHAR(2) NOT NULL,
     flagUrl VARCHAR(255)
  );


CREATE TABLE IF NOT EXISTS gameday
  (
     id     INT auto_increment PRIMARY KEY,
     number INT NOT NULL,
     season VARCHAR(9) NOT NULL
  );

CREATE TABLE IF NOT EXISTS game
  (
     id           INT auto_increment PRIMARY KEY,
     hometeamId   INT NOT NULL,
     awayteamId   INT NOT NULL,
     gamedayId    INT NOT NULL,
     date         DATE NOT NULL,
     reffereeName VARCHAR(50) NOT NULL,
     FOREIGN KEY(hometeamId) REFERENCES teams(id),
     FOREIGN KEY(awayteamId) REFERENCES teams(id),
     FOREIGN KEY(gamedayId) REFERENCES gamedays(id)
  );

  CREATE TABLE IF NOT EXISTS gameevent
  (
     id        INT auto_increment PRIMARY KEY,
     gameId    INT NOT NULL,
     minute    INT NOT NULL,
     event     VARCHAR(50) NOT NULL,
     activePlayer INT NOT NULL,
     passivePlayer INT NOT NULL,
     FOREIGN KEY(gameId) REFERENCES games(id)
  ); 