--1 List the films where the yr is 1962. [Show id, title]

SELECT id, title FROM movie
    WHERE yr = 1962

--2. When was Citizen Kane released

SELECT yr FROM movie
    WHERE title = 'Citizen Kane'

--3. List all of the Star Trek movies, include the id, title and yr. Order results by year.

SELECT id, title, yr FROM movie
    WHERE title LIKE '%Star Trek%'
    ORDER BY yr

--4. Select the id for actor 'Glenn Close'

SELECT id FROM actor
    WHERE name = 'Glenn Close'

--5. What is the id of the film 'Casablanca'

SELECT id FROM movie
    WHERE title = 'Casablanca'

--6. Obtain cast list for 'Casablanca'

SELECT name
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE title = 'Casablanca'

--7. Obtain cast list for the film 'Alien'

SELECT name
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE title = 'Alien'

--8. List the films in which 'Harrison Ford' has appeared

SELECT title
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE name = 'Harrison Ford'

--9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [ord = 1 means starring role]

SELECT title
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE name = 'Harrison Ford'
        AND ord != 1

--10. List films & leading star for all 1962 films

SELECT title, name
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE ord = 1
        AND yr = 1962

--11. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr, COUNT(title)
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE name = 'John Travolta'
    GROUP BY name, yr
    HAVING COUNT(title) > 2

--12. List the film title and the leading actor for all of the films 'Julie Andrews' played in

SELECT DISTINCT m.title, a.name
    FROM(SELECT movie.*
        FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actor.id = actorid)
        WHERE name = 'Julie Andrews'
    ) AS m
    JOIN (SELECT actor.*, casting.movieid AS movieid
        FROM actor JOIN casting ON (actorid = actor.id)
        WHERE ord = 1
    ) AS a
ON m.id = a.movieid
ORDER by m.title   

--13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

SELECT name
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE ord = 1
    GROUP BY name
    HAVING COUNT(name) >= 30

--14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title, COUNT(actorid)
    FROM movie JOIN casting ON (movieid = movie.id)
        JOIN actor ON (actorid = actor.id)
    WHERE yr = 1978
    GROUP BY title
    ORDER BY COUNT(actorid) DESC, title

--15. List all the people who have worked with 'Art Garfunkel'

SELECT a.name
    FROM(SELECT movie.*
        FROM movie 
        JOIN casting 
        ON (movieid = movie.id)
        JOIN actor 
        ON (actorid = actor.id)
        WHERE name = 'Art Garfunkel'
    ) AS m
    JOIN(SELECT actor.*, casting.movieid
        FROM actor
        JOIN casting
        ON actorid = actor.id
        WHERE name != 'Art Garfunkel'
    ) AS a
    ON m.id = a.movieid