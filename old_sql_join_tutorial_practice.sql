-- Join operations from old SQL tutorial for more practice (https://sqlzoo.net/wiki/Old_JOIN_Tutorial)

-- Utilizes ttms, ttws, ttmd, and country databases

-- 1. Show the athelete (who) and the country name for medal winners in 2000. 
-- ttms(games,color,who,country)
-- country(id,name)   

SELECT who, name
FROM ttms JOIN country ON (ttms.country=country.id)
WHERE games = 2000

-- 2. Show the who and the color of the medal for the medal winners from 'Sweden'. 

SELECT who, color
FROM ttms JOIN country ON (ttms.country = country.id)
WHERE name = 'Sweden'

-- 3. Show the years in which 'China' won a 'gold' medal. 

SELECT games
FROM ttms JOIN country ON (ttms.country = country.id)
WHERE name = 'China' AND color = 'gold'

-- Join operations using Women's table tennis olympics database (ttws) and games database
-- ttws(games,color,who,country)
-- games(yr,city,country) 
-- 4. Show who won medals in the 'Barcelona' games. 

SELECT who
FROM ttws JOIN games ON (ttws.games=games.yr)
WHERE city = 'Barcelona'

-- 5. Show which city 'Jing Chen' won medals. Show the city and the medal color. 
  
SELECT city, color
FROM ttws JOIN games ON (ttws.games = games.yr)
WHERE who = 'Jing Chen'

-- 6. Show who won the gold medal and the city. 

SELECT who, city
FROM ttws JOIN games ON (ttws.games = games.yr)
WHERE color = 'gold'

-- Uses table tennis men's doubles database ttmd
-- ttmd(games,color,team,country)
-- team(id,,name)   

-- 7. Show the games and color of the medal won by the team that includes 'Yan Sen'. 

SELECT games, color
FROM ttmd JOIN team ON (ttmd.team = team.id)
WHERE name = 'Yan Sen'

-- 8. Show the 'gold' medal winners in 2004. 

SELECT name
FROM ttmd JOIN team ON (ttmd.team = team.id)
WHERE color = 'gold' AND games = '2004'

-- 9. Show the name of each medal winner country 'FRA'. 

SELECT name
FROM team JOIN ttmd ON (team.id = ttmd.team)
WHERE country = 'FRA'
