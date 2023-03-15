import { Request, Response, NextFunction } from 'express';
import { getLeagues, LeagueQueries } from '../models/League';
import { InternalServerError } from '../shared/exceptions/Exceptions';

export async function getAllLeagues(
    req: Request,
    res: Response,
    next: NextFunction
) {
    try {
        const leagues = await getLeagues(LeagueQueries.GET_ALL);

        if (!leagues) {
            throw new InternalServerError('Could not fetch leagues');
        }

        res.status(200).json({
            success: true,
            leagues,
        });
    } catch (err) {
        next(err);
    }
}
