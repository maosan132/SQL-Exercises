-- MOVIE
-- id	title	yr	director	budget	gross

-- ACTOR
-- id	name

-- CASTING
-- movieid	actorid	ord

-- More details about the database: https://napier.sqlzoo.net/wiki/More_details_about_the_database.

-- 1962 movies
-- 1.
-- List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962


-- When was Citizen Kane released?
-- 2.
-- Give year of 'Citizen Kane'.

SELECT yr
FROM movie
WHERE title LIKE 'Citiz%'


-- Star Trek movies
-- 3.
-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order s by year.

SELECT id, title, yr
FROM movie
WHERE title LIKE '%trek%'
ORDER BY yr



-- id for actor Glenn Close
-- 4.
-- What id number does the actor 'Glenn Close' have?

SELECT id
FROM actor
WHERE name = 'Glenn Close'



-- id for Casablanca
-- 5.
-- What is the id of the film 'Casablanca'

SELECT id
FROM movie
WHERE title like 'Casab%'


-- Get to the point
-- Cast list for Casablanca
-- 6.
-- Obtain the cast list for 'Casablanca'.
-- Use movieid=11768, (or whatever value you got from the previous question)

SELECT actor.name
FROM actor JOIN casting ON casting.actorid = actor.id
WHERE casting.movieid = 11768


-- Alien cast list
-- 7.
-- Obtain the cast list for the film 'Alien'

SELECT actor.name
FROM actor JOIN casting ON casting.actorid = actor.id
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Alien'


-- Harrison Ford movies
-- 8.
-- List the films in which 'Harrison Ford' has appeared

SELECT movie.title
FROM movie JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';


-- Harrison Ford as a supporting actor
-- 9.
-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT title
FROM movie JOIN casting ON movieid = movie.id
JOIN actor ON actor.id = actorid
WHERE name LIKE 'Harrison Ford'
AND ord != 1


-- Lead actors in 1962 movies
-- 10.
-- List the films together with the leading star for all 1962 films.

SELECT title, name
FROM movie JOIN casting ON movieid = movie.id
JOIN actor ON actor.id = actorid
WHERE yr = 1962
AND ord = 1


-- Harder Questions

-- Busy years for Rock Hudson
-- 11.
-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr, COUNT(title)
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1
ORDER BY COUNT(title) DESC
LIMIT 2;


-- Lead actor in Julie Andrews movies
-- 12.
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

Did you get "Little Miss Marker twice"?
SELECT title, name 
FROM movie  JOIN casting ON movie.id = movieid
JOIN actor ON actorid=actor.id
WHERE ord = 1
AND movieid IN ( SELECT movieid FROM casting JOIN actor ON actorid = actor.id WHERE name = 'Julie Andrews') 



-- Actors with 15 leading roles
-- 13.
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT name
FROM actor JOIN casting ON id = actorid
AND ord = 1
GROUP BY name
HAVING COUNT(name) > 14


-- 14.
-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title, COUNT(actorid)
FROM movie JOIN casting ON movieid = movie.id
JOIN actor ON actor.id = actorid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title;



-- 15.
-- List all the people who have worked with 'Art Garfunkel'.

SELECT a.name
FROM (SELECT movie.* FROM movie JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Art Garfunkel') AS m
JOIN (SELECT actor.*, casting.movieid FROM actor JOIN casting ON casting.actorid = a

