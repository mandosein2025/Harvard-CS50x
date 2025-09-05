-- Select the description of the crime scene on July 28, 2020, at Chamberlin Street
SELECT description FROM crime_scene_reports
WHERE year = 2020 AND month = 7 AND day =  28 AND street = 'Chamberlin Street';

-- Get interviews from July 28, 2020, where the transcript mentions 'courthouse'
SELECT name, transcript FROM interviews
WHERE year = 2020 AND month = 7 AND day =  28 AND transcript LIKE '%courthouse%';

-- Get license plates of vehicles that exited the courthouse between 10:15 and 10:25
SELECT license_plate FROM courthouse_security_logs
WHERE year = 2020 AND month = 7 AND day =  28 AND hour = 10
AND activity = 'exit' AND minute BETWEEN 15 AND 25;

-- Find the names of people associated with the license plates that exited the courthouse
SELECT name FROM people
WHERE license_plate IN (
SELECT license_plate FROM courthouse_security_logs
WHERE year = 2020 AND month = 7 AND day =  28 AND hour = 10
AND activity = 'exit' AND minute BETWEEN 15 AND 25);

-- Retrieve all information about people with the specific license plates and short phone calls
SELECT * FROM people
WHERE license_plate IN (
SELECT license_plate FROM courthouse_security_logs
WHERE year = 2020 AND month = 7 AND day =  28 AND hour = 10
AND activity = 'exit' AND minute BETWEEN 15 AND 25)
AND phone_number IN (
SELECT caller FROM phone_calls
WHERE year = 2020 AND month = 7 AND day =  28 AND duration <= 60);

-- Get all short phone calls on July 28, 2020, involving people with the specified license plates
SELECT caller, receiver FROM phone_calls
WHERE year = 2020 AND month = 7 AND day =  28 AND duration <= 60
AND caller IN(
SELECT phone_number FROM people
WHERE license_plate IN (
SELECT license_plate FROM courthouse_security_logs
WHERE year = 2020 AND month = 7 AND day =  28 AND hour = 10
AND activity = 'exit' AND minute BETWEEN 15 AND 25)
AND phone_number IN (
SELECT caller FROM phone_calls
WHERE year = 2020 AND month = 7 AND day =  28 AND duration <= 60)
);

-- Get all information of people whose phone numbers match a specific list
SELECT * FROM people
WHERE phone_number = '(996) 555-8899' OR phone_number = '(892) 555-8872'
OR phone_number = '(375) 555-8161' OR phone_number = '(717) 555-1342'
OR phone_number = '(725) 555-3243';

-- Get the flight ID departing from Fiftyville on July 29, 2020, and select the earliest flight
SELECT flights.id FROM flights
JOIN airports ON airports.id = flights.origin_airport_id
WHERE year = 2020 AND month = 7 AND day =  29 AND city = 'Fiftyville'
ORDER BY hour, minute LIMIT 1;

-- Find passengers on flight 36 whose names are Roger, Russell, Evelyn, or Ernest
SELECT name FROM people
JOIN passengers ON passengers.passport_number = people.passport_number
JOIN flights ON flights.id = passengers.flight_id
WHERE flights.id = 36 AND passengers.passport_number IN (
SELECT passport_number FROM people
WHERE name = 'Roger' OR name = 'Russell'
OR name = 'Evelyn' OR name = 'Ernest');

-- Find passengers on flight 36 whose names are Larry, Jack, Melissa, Philip, or Berthold
SELECT name FROM people
JOIN passengers ON passengers.passport_number = people.passport_number
JOIN flights ON flights.id = passengers.flight_id
WHERE flights.id = 36 AND passengers.passport_number IN (
SELECT passport_number FROM people
WHERE name = 'Larry' OR name = 'Jack' OR name = 'Melissa'
OR name = 'Philip' OR name = 'Berthold');

-- Find the destination city of flight 36 using the destination airport ID
SELECT city FROM airports
WHERE id = (
SELECT destination_airport_id FROM flights
JOIN airports ON airports.id = flights.origin_airport_id
WHERE flights.id = 36);
