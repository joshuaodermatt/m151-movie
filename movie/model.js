import {Movies, Ratings} from "../model/model.js";
import {Op} from "sequelize";
import {sequelize} from "../config/sequelize.js";



export async function getAll(id) {
    return Movies.findAll({
        where: {
            [Op.or]: [
                {public: true},
                {user: id}
            ]
        },
    });
}

export async function getAllMoviesWithRating(Id) {
    const movies = await sequelize.query("SELECT RatedMovies.id, RatedMovies.title, RatedMovies.year, RatedMovies.user, RatedMovies.public, RatedMovies.Rating, IFNULL(R.rating,0) as 'userRating' FROM RatedMovies " +
        " Left JOIN Ratings R on RatedMovies.id = R.movie and R.user = "+Id+
        " WHERE RatedMovies.public = true OR RatedMovies.user = " +Id+";" );
    return movies[0];
}

export async function get(id, uid) {

    let res = await Movies.findByPk(id);
    if (parseInt(res.user) === parseInt(uid) || res.public === true) {
        return res;
    }
    return null;
}

export async function remove(id, uid) {
    let res = await Movies.findByPk(id);
    let x = await Ratings.findAll({ where: { movie: id } });
    if (parseInt(x.user) === parseInt(uid) || res.public === true) {
        for (const it of x) {
            await it.destroy();
        }
        await res.destroy();
    }
}

export function save(movie) {
    Movies.upsert(movie);
}
