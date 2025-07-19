-- Self join practice

-- Source: https://sqlzoo.net/wiki/Self_join

-- Uses databases stops, routes

-- 1. How many stops are in the database. 

SELECT COUNT(name)
FROM stops

-- 2. Find the id value for the stop 'Craiglockhart' 

SELECT id
FROM stops
WHERE name = 'Craiglockhart'

-- 3. Give the id and the name for the stops on the '4' 'LRT' service. 

SELECT DISTINCT id, name
FROM stops JOIN route ON (stops.id =  route.stop)
WHERE route.num = '4' AND route.company = 'LRT'

-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes. 

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road. 

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149

-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross' 

-- Craiglockhart and London Road
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'

-- Fairmilehead and Tollcross

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Fairmilehead' AND stopb.name = 'Tollcross'

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') 

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON (a.company = b.company
AND a.num = b.num)
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Haymarket' AND stopb.name = 'Leith'

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' 

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services. 

SELECT DISTINCT s2.name, b.company, b.num
FROM route a JOIN route b
ON (a.company, a.num) = (b.company, b.num)
JOIN stops s1 ON a.stop = s1.id
JOIN stops s2 ON b.stop = s2.id
WHERE s1.name = 'Craiglockhart' AND a.company = 'LRT'

-- 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus. 

SELECT DISTINCT r1.num as bus1num, r1.company AS bus1company,
transfer.name AS transfer,
r3.num AS bus2num,
r3.company AS bus2company
FROM route r1
JOIN stops s1 ON r1.stop = s1.id -- adding stops to route
JOIN route r2 ON r1.company = r2.company AND r1.num = r2.num -- all stops on first bus route
JOIN stops transfer ON r2.stop = transfer.id -- name of transfer stop
JOIN route r3 ON transfer.id = r3.stop -- buses must stop at transfer
JOIN route r4 ON r3.company = r4.company AND r3.num = r4.num -- where does the second bus go?
JOIN stops s2 ON r4.stop = s2.id -- can find Lochend on second half
WHERE s1.name = 'Craiglockhart'
AND s2.name = 'Lochend'
AND (r1.company != r3.company OR r1.num != r3.num)
ORDER BY bus1num, bus1company, transfer.name, bus2num, bus2company




