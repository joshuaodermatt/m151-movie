CREATE DATABASE `movie-db`;

USE movie-db;

CREATE TABLE `Movies`
(
    `id`     int(11) NOT NULL AUTO_INCREMENT,
    `title`  varchar(255) DEFAULT NULL,
    `year`   int(11)      DEFAULT NULL,
    `user`   int(11)      DEFAULT NULL,
    `public` boolean      DEFAULT true,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Users`
(
    `id`        int(11) NOT NULL AUTO_INCREMENT,
    `firstname` varchar(255) DEFAULT NULL,
    `lastname`  varchar(255) DEFAULT NULL,
    `username`  varchar(255) DEFAULT NULL,
    `password`  varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Ratings`
(
    `id`     int(11) NOT NULL AUTO_INCREMENT,
    `user`   int(11) DEFAULT NULL,
    `movie`  int(11) DEFAULT NULL,
    `rating` int(11) DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (user) REFERENCES Users (id),
    FOREIGN KEY (movie) REFERENCES Movies (id)
);

INSERT INTO `Users` (firstname, lastname, username, password)
values ("Max", "Mustermann", "joshua", "10b43971a8295f3720f38fbcdd9d6ac6");
INSERT INTO `Users` (firstname, lastname, username, password)
values ("Herbert", "Mustermann", "joshi", "10b43971a8295f3720f38fbcdd9d6ac6");

CREATE OR REPLACE VIEW RatedMovies AS
SELECT Movies.id, Movies.title, Movies.year, Movies.user, Movies.public, IFNULL(avg(rating), 0) as Rating
FROM Movies
         Left join Ratings R on Movies.id = R.movie
GROUP BY Movies.id;

