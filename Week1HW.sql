#1 Which destination in the flights database is the furthest distance away, 
# based on information in the flights table.  
# Show the SQL query(s) that support your conclusion.
SELECT DISTINCT(origin), dest, distance FROM flights 
  ORDER BY distance DESC
  LIMIT 5;
# Looks like Honolulu, followed by Anchorage

#2. What are the different numbers of engines in the planes table?  
# For each number of engines, which aircraft have the most number of seats?  
# Show the SQL statement(s) that support your result.
SELECT DISTINCT(gp.engines), gp.maxseats, p.manufacturer
  FROM planes p
  INNER JOIN 
    (SELECT engines, MAX(seats) as maxseats
	 FROM planes
     GROUP BY engines) as gp
  ON gp.engines = p.engines
  AND gp.maxseats = p.seats
  ORDER BY engines DESC;

#3.Show the total number of flights.
SELECT COUNT(*) as totalFlights FROM flights;

#4.Show the total number of flights by airline (carrier).
SELECT carrier, COUNT(*) totalFlights FROM flights 
  GROUP BY carrier;

#5.Show all of the airlines, ordered by number of flights in descending order.
SELECT carrier, COUNT(*) totalFlights FROM flights 
  GROUP BY carrier 
  ORDER BY totalFlights DESC;

#6. Show only the top 5 airlines, by number of flights, 
# ordered by number of flights in descending order.
SELECT carrier, COUNT(*) totalFlights FROM flights 
  GROUP BY carrier 
  ORDER BY totalFlights DESC limit 5;

#7.Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, 
# ordered by number of flights in descending order.
SELECT carrier, COUNT(*) totalFlights FROM flights 
  WHERE distance >= 1000
  GROUP BY carrier 
  ORDER BY totalFlights DESC limit 5;

#8. Create a question that (a) uses data from the flights database, 
# and (b) requires aggregation to answer it, and write down both the question, 
# and the query that answers the question.

# Q:   What is the average daily temperature at Newark Liberty Airport in 
# January 2013 (round to the nearest digit)?
SELECT ROUND(AVG(temp),0) as avgtemp, origin FROM weather
  WHERE origin = "EWR"
  and YEAR = 2013 AND Month = 1;
