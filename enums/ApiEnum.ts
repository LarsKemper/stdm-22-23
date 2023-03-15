import { serverUrl, apiVersion } from '@lib/constants';

const apiBase = `${serverUrl}/${apiVersion}`;

export enum API {
  REGISTER = 'auth/register',
  LOGIN = 'auth/login',
  PLAYERS = 'players',
  TEAMS = 'teams',
}

export const routes = {
  register: (): string => `${apiBase}/${API.REGISTER}`,
  login: (): string => `${apiBase}/${API.LOGIN}`,
  players: (): string => `${apiBase}/${API.PLAYERS}`,
  teams: (): string => `${apiBase}/${API.TEAMS}`,
};