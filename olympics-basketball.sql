CREATE DATABASE olympicsBasketball;
USE olympicsBasketball;
-- drop table then re add due to salary name change
-- add height (feet and inches separately)
CREATE TABLE teamUSA ( playerID INT PRIMARY KEY,
					   firstName VARCHAR(15),
					   lastName VARCHAR(15),
                       age INT,
                       position VARCHAR(1),
                       heightFt INT,
					   heightIn INT,
                       weightLb INT,
                       team VARCHAR(35),
                       regSeasonGamesPlayed INT,
                       salary23_24$ INT); 

INSERT INTO teamUSA VALUES (1,'LeBron', 'James', 39, 'F', 6, 9, 250, 'Los Angeles Lakers', 71, 47607350),
						   (2, 'Steph', 'Curry', 36, 'G', 6, 2, 185, 'Golden State Warriors', 74, 51915615),
						   (3, 'Kevin', 'Durant', 36, 'F', 6, 10, 225, 'Phoenix Suns', 75, 47649433),
                           (4, 'Jayson', 'Tatum', 26, 'F', 6, 8, 205, 'Boston Celtics', 74, 32600060),
                           (5, 'Joel', 'Embiid', 30, 'C', 7, 0, 280, 'Philadelphia 76ers', 39, 46900000),
                           (6, 'Kawhi', 'Leonard', 33, 'F', 6, 7, 225, 'Los Angeles Clippers', 68, 45640084),
                           (7, 'Anthony', 'Davis', 31, 'F', 6, 10, 253,'Los Angeles Lakers', 76, 40600080),
                           (8, 'Devin', 'Booker', 27, 'G', 6, 5, 206, 'Phoenix Suns', 68, 36016200), 
                           (9, 'Anthony', 'Edwards', 23, 'G', 6, 4, 225,'Minnesota Timberwolves', 79, 9219512),
                           (10, 'Bam', 'Adebayo', 27, 'F', 6, 9, 225,'Miami Heat', 71, 32600060),
                           (11, 'Jrue', 'Holiday', 34, 'G', 6, 3, 229,'Boston Celtics', 69, 36861707),
                           (12, 'Tyrese', 'Haliburton', 24, 'G', 6, 5, 185,'Indiana Pacers', 69, 5808435); 
                           
SELECT * FROM olympicsbasketball.teamUSA;
#DROP TABLE teamusa;

-- Kawhi Leonard is withdrawn from the Team USA due to injury where it is reported he will undergo surgery for his knee. 
-- Many believe either Jaylen Brown (reigning Finals MVP) or Kyrie Irving should be called up for the 12th roster slot
-- To many's surprise Celtics' G Derrick White is chosen to replace Kawhi Leonard.
-- 3 of the Celtics starting 5 are now on the Olympic Squad, which is incredible. However, Brown misses out.
-- This raises many conspiracy theories with his dispute with Nike being the most common one.

-- Remove Kawhi Leonard from the roster and add Derrick White ...

DELETE FROM olympicsbasketball.teamusa WHERE playerID = 6 AND firstName = 'Kawhi';

INSERT INTO olympicsbasketball.teamusa VALUES (13, 'Derrick', 'White', 30, 'G', '6', '4', 190, 'Boston Celtics', 73, 17607143);

# Queries

-- Who is the youngest player selected for Team USA ?

SELECT firstName, lastName, age
FROM olympicsbasketball.teamusa
ORDER BY age ASC
LIMIT 1;

-- Which many players have a name that starts with J ?

SELECT *
FROM olympicsbasketball.teamusa
WHERE firstName LIKE 'J%' or lastName LIKE 'J%';

-- Who is the tallest player ?

SELECT firstName, lastName, position, heightFt, heightIn
FROM olympicsbasketball.teamusa
ORDER BY (heightFt * 12) + heightIn DESC
LIMIT 1;

-- How many players do they have in each position ?

SELECT position, COUNT(*) AS 'Number of players'
FROM olympicsbasketball.teamUSA
GROUP BY position;

-- Present the roster in order of height and weight

SELECT *
FROM olympicsbasketball.teamusa
ORDER BY (heightFt * 12) + heightIn, weightLb;

-- What is the average height of a Forward on the Team USA roster ?

SELECT position, floor(AVG((heightFt * 12) + heightIn) / 12) as 'Average Height for a Forward (ft)', round(AVG((heightFt * 12) + heightIn) % 12, 0) as 'Average Height for a Forward (in)'
FROM olympicsbasketball.teamUSA
WHERE position = 'F';

-- Who is the youngest Phoenix Sun ?

SELECT firstName, lastName, age, team
FROM olympicsbasketball.teamUSA
WHERE team = 'Phoenix Suns'
ORDER BY age ASC
LIMIT 1;

-- Who on the roster weighs 230lbs or higher ?

SELECT firstName, lastName, position, heightFt, heightIn, weightLb
FROM olympicsbasketball.teamusa
WHERE weightLb >=230
ORDER BY weightLb ASC;

-- Which NBA teams are represented on the Team USA roster ?

SELECT team as 'NBA Team', COUNT(team) AS 'Amount of players represented'
FROM olympicsbasketball.teamusa
GROUP BY team
ORDER BY COUNT(team) DESC;

-- Which players have an NBA teammate on the roster ?

SELECT firstName, lastName, position, team
FROM olympicsbasketball.teamusa
WHERE team IN (SELECT team
			   FROM olympicsbasketball.teamusa
               GROUP BY team
               HAVING COUNT(*) != 1
               )
ORDER BY team;

-- Which players are without an NBA teammate on the roster ?

SELECT firstName, lastName, position, team
FROM olympicsbasketball.teamusa
WHERE team IN (SELECT team
			   FROM olympicsbasketball.teamusa
               GROUP BY team
               HAVING COUNT(*) = 1
                )
ORDER BY lastName ASC;

-- Who is the average weight of a Celtic Guard on the roster ? 

SELECT position, ROUND(AVG(weightLb), 1) AS 'Average weight (lb)', team
FROM olympicsbasketball.teamusa
WHERE team = 'Boston Celtics' and position = 'G'; 

-- Who played more than 75 regular season games in 23/24 on the roster ?

SELECT firstName, lastName, age, position
FROM olympicsbasketball.teamusa
WHERE regSeasonGamesPlayed > 75;

-- Compare regular season games played between players 30 and older vs 29 and younger.
SELECT
	CASE WHEN age >= 30 THEN '30 and over'
		 ELSE '29 and younger'
	END AS 'ageGroup',
ROUND(AVG(regSeasonGamesPlayed), 1) AS 'Average regular season games played'
FROM olympicsbasketball.teamusa
GROUP BY ageGroup;

-- What is the average salary of a member of Team USA ?

SELECT ROUND(AVG(salary23_24$) / POW(10,6), 1) AS 'Average salary of Team USA roster M$'
FROM olympicsbasketball.teamusa;

-- How much were Team USA players get paid this year ?

SELECT ROUND((SUM(salary23_24$)) / POW(10,6), 1) AS 'Total salary of Team USA combined M$'
FROM olympicsbasketball.teamusa;

-- Who is paid the most, the least, and what is the difference in their salaries ?

SELECT firstName, lastName, age, position, team, salary23_24$
FROM olympicsbasketball.teamusa
WHERE salary23_24$ = (SELECT MAX(salary23_24$) FROM olympicsbasketball.teamusa);

SELECT firstName, lastName, age, position, team, salary23_24$
FROM olympicsbasketball.teamusa
WHERE salary23_24$ = (SELECT MIN(salary23_24$) FROM olympicsbasketball.teamusa);

SELECT ROUND((max(salary23_24$)-min(salary23_24$)) / POW(10,6), 1) AS 'Difference in salary M$'
FROM olympicsbasketball.teamusa;
        
-- Compare the salaries between players younger than 32 and 33 or older. 

SELECT 
	CASE WHEN age >= 33 THEN '33 or older'
    ELSE '32 or younger'
    END AS 'ageGroup',
ROUND(AVG(salary23_24$) / POW(10,6), 1) AS 'Average salary M$'
FROM olympicsbasketball.teamusa
GROUP BY ageGroup;

-- Olympic basketball is underway.
-- Team USA rout through group C as expected with their immense talent.
-- They top the group going 3-0, winning by an average margin of 27 pts.
-- They then go onto beating Brazil, Serbia and then France in the Gold Medal game.
-- LeBron James wins Olympic MVP.

-- Team USA averages over the 6 Olympic games :

CREATE TABLE Stats ( 	  playerID INT PRIMARY KEY,	
						  gamesPlayed INT,
                          AVGminsPlayed DECIMAL(3,1),
                          AVGpoints DECIMAL(3,1),
                          AVGrebounds DECIMAL(3,1),
                          AVGassists DECIMAL(3,1),
                          AVGsteals DECIMAL(3,1),
                          AVGblocks DECIMAL(3,1),
                          AVGfgPct DECIMAL(4,1),
                          AVG3pPct DECIMAL(4,1),
                          AVGftPct DECIMAL(4,1),
                          AVGturnovers DECIMAL(3,1),
                          AVGfouls DECIMAL(2,1),
                          TOTminsPlayed INT,
                          AVGplusMinus DECIMAL(3,1),
                          AVGefficiency DECIMAL(3,1),
                          FOREIGN KEY (playerID) REFERENCES teamusa(playerID)
					 );
                          
SELECT * FROM olympicsbasketball.stats;

#DROP TABLE Stats;

INSERT INTO olympicsbasketball.stats VALUES (1, 6, 24.5, 14.2, 6.8, 8.5, 1.3, 0.3, 66.0, 30.8, 73.3, 4.0, 1.7, 147, 14.0, 23.5),
											(4, 4, 17.8, 5.3, 5.3, 1.5, 1.0, 0.5, 38.1, 0.0, 83.3, 0.5, 0.8, 71, 4.3, 9.5),
                                            (9, 6, 16.3, 12.8, 2.8, 1.2, 1.3, 0.3, 58.0, 48.0, 58.3, 1.7, 0.8, 98, 7.7, 12.5), 
                                            (11, 5, 19.0, 7.6, 1.8, 3.6, 0.4, 0.6, 55.6, 50.0, NULL, 1.0, 1.0, 95, 6.4, 10.6), 
                                            (2, 6, 23.3, 14.8, 3.2, 2.5, 0.7, 0.0, 50.0, 47.8, 100.0, 1.7, 1.3, 140, 14.3, 14.5),
                                            (10, 6, 16.0, 6.0, 3.7, 1.3, 0.8, 0.3, 53.3, 33.3, 50.0, 1.2, 1.2, 96, 5.3, 8.5),
                                            (8, 6, 22.0, 11.7, 2.7, 3.3, 0.5, 0.0, 56.8, 56.5, 77.8, 0.5, 2.0, 132, 13.0, 14.2),
                                            (5, 5, 16.8, 11.2, 3.8, 1.4, 0.2, 1.0, 56.8, 54.5, 72.7, 1.8, 1.2, 84, 8.2, 12.0),
                                            (7, 6, 16.5, 8.3, 6.7, 2.0, 1.2, 1.5, 62.5, 50.0, 81.8, 0.5, 2.2, 99, 7.3, 16.8),
                                            (12, 3, 8.7, 2.7, 0.0, 0.7, 0.3, 0.0, 60.0, 50.0, NULL, 0.3, 1.0, 26, 0.3, 2.7),
                                            (3, 6, 22.3, 13.8, 3.2, 2.3, 1.0, 0.2, 54.0, 51.9, 93.8, 1.0, 1.2, 134, 14.0, 15.5),
                                            (13, 5, 16.0, 3.8, 1.4, 1.6, 1.4, 1.0, 41.2, 30.8, 50.0, 0.0, 1.4, 80, 5.0, 7.0)
									;
                                    

-- What was the lowest percentage a Team USA player shot from the field ? 

SELECT MIN(AVGfgpct) AS 'Lowest FG%' FROM Stats;

-- Which players are apart of the 50/40/90 club after the tournament ?

SELECT firstName, lastName, position, AVGfgpct AS 'FG%', AVG3ppct AS '3P%', AVGftpct AS 'FT%'
FROM stats
JOIN teamusa
ON stats.playerID = teamusa.playerID
WHERE AVGfgpct >= 50 AND AVG3ppct >= 40 AND AVGftpct >= 90; 

-- The team had some stat stuffers. List the top 5 players in PRA.

SELECT firstName, lastName, position, AVGpoints, AVGrebounds, AVGassists, AVGminsPlayed, (AVGpoints + AVGrebounds + AVGassists) AS 'Average PRA per gm'
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
ORDER BY (AVGpoints + AVGrebounds + AVGassists) DESC
LIMIT 5;

-- What about the 2 lowest PRA totals.

SELECT firstName, lastName, position, AVGpoints, AVGrebounds, AVGassists, AVGminsPlayed, (AVGpoints + AVGrebounds + AVGassists) AS 'Average PRA per gm'
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
ORDER BY (AVGpoints + AVGrebounds + AVGassists) ASC
LIMIT 2;

-- On average, how did the team shoot from 3 pt range ?

SELECT 'TeamUSA' AS 'Nation', ROUND(AVG(AVG3ppct), 1) AS 'Team 3P%'
FROM  Stats;

-- Rank the players based on efficiency.

SELECT firstName, lastName, position, AVGminsPlayed, AVGefficiency
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
ORDER BY AVGefficiency DESC;

-- There was some great defense played. List the team in order of TOTALstocks (steals + blocks).

SELECT firstName, lastName, position, ROUND((AVGsteals * gamesPlayed)) AS 'Total Steals', ROUND((AVGblocks * gamesPlayed)) AS 'Total Blocks', ROUND((AVGsteals * gamesPlayed))+ROUND((AVGblocks * gamesPlayed)) AS 'Total Stocks'
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
ORDER BY ROUND((AVGsteals * gamesPlayed))+ROUND((AVGblocks * gamesPlayed)) DESC; 

-- How many fouls did the team as a whole commit per game ?

SELECT 'TeamUSA' AS 'Nation', ROUND(SUM(ROUND((AVGfouls*gamesplayed))) / 6) AS 'Average Team Fouls per game'
FROM Stats;

-- Display the roster's assist to turnover ratio ?

SELECT firstName, lastName, position, ROUND(AVGassists*gamesPlayed) AS 'Total Assists', ROUND(AVGturnovers*gamesPlayed) AS 'Total Turnovers', ROUND(((AVGassists*gamesPlayed) / (AVGturnovers*gamesPlayed)),1) AS 'Assist/Turnover Ratio'
FROM teamUSA
JOIN Stats
ON teamusa.playerID = stats.playerID
ORDER BY ROUND(((AVGassists*gamesPlayed) / (AVGturnovers*gamesPlayed)),1) DESC;

-- Derrick White has 0 turnover, which has given a result of NULL. However with logic we can see, he didn't have the worst ratio, infact the best.

-- How many TOTAL points did each player score ? 

SELECT firstName, lastName, ROUND((SUM(AVGpoints)*(gamesPlayed))) AS 'Total Points'
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
GROUP BY teamusa.playerID
ORDER BY ROUND((SUM(AVGpoints)* (gamesPlayed))) DESC; 

-- Display the average shooting splits by position over the tournament. What conclusions can you draw from this ?

SELECT position, ROUND(AVG(AVGfgpct), 1) AS 'FG%', ROUND(AVG(AVG3ppct), 1) AS '3P%', ROUND(AVG(AVGftpct), 1) AS 'FT%'
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
GROUP BY position;

# The 'C' position is made up of only one person - Joel Embiid. The forwards were more efficient from the field, whilst the guards shot better from 3. 
# All 3 positions shot below 80% from the FT line which is a surprise. 

-- Who averaged the most points under the age of 30 and what was his performance like ?

SELECT firstName, lastName, position, age, AVGminsPlayed, AVGpoints, AVGrebounds, AVGassists, AVGfgpct, AVG3ppct, AVGftpct, AVGsteals, AVGblocks, AVGturnovers, AVGplusMinus, AVGefficiency
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
WHERE age < 30
ORDER BY AVGpoints DESC
LIMIT 1;

-- Which players didn't attempt a free throw ?

SELECT firstName, lastName
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
WHERE AVGftpct IS NULL;

-- Which Laker grabbed the most rebounds ?

SELECT firstName, lastName, position, team, ROUND((AVGrebounds * gamesPlayed)) AS 'Total Rebounds'
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
WHERE team LIKE '%Lakers%'
ORDER BY ROUND((AVGrebounds * gamesPlayed)) DESC
LIMIT 1;

-- How many STOCKS did Phoenix Suns players have in total ?

SELECT team, SUM(ROUND((AVGsteals*gamesPlayed))) AS 'Total Steals', SUM(ROUND((AVGblocks*gamesPlayed))) AS 'Total Blocks'
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
WHERE team LIKE '%Suns%'
GROUP BY team;


-- Which 3 players shot the best from 3 ?

SELECT firstName, lastName, position, AVG3ppct
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
ORDER BY Avg3ppct DESC
LIMIT 3;

-- Which Celtic shot the best from the field ? 

SELECT firstName, lastName, position, team, AVGfgpct
FROM Stats
JOIN TeamUSA
ON stats.playerID = teamusa.playerID
WHERE team LIKE '%Celtics%'
ORDER BY AVGfgpct DESC
LIMIT 1;

-- What was the 3 tallest player's FG percentage ?

SELECT firstName, lastName, position, heightFt, heightIn, AVGfgPct
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
ORDER BY (heightFt*12 + heightIn) DESC 
LIMIT 3;

-- How many rebounds did the shortest player grab ?

SELECT firstName, lastName, position, heightFt, heightIn, AVGrebounds
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
ORDER BY (heightFt*12 + heightIn) ASC
LIMIT 1;

-- Which forward had the lowest FG percentage ?

SELECT firstName, lastName, position, AVGfgpct
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
WHERE position = 'F'
ORDER BY AVGfgPct ASC
LIMIT 1;

-- Who were the most valuable players when on the court ? Rank the team in terms +/- per min.

SELECT firstName, lastName, position, ROUND((AVGminsPlayed*gamesPlayed)) AS 'Total Mins Played', ROUND((AVGplusMinus*gamesPlayed)) AS 'Total +/-', (ROUND((AVGplusMinus*gamesPlayed)))/ROUND((AVGminsPlayed*gamesPlayed)) AS '+/- per Min'
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
ORDER BY (ROUND((AVGplusMinus*gamesPlayed)))/ROUND((AVGminsPlayed*gamesPlayed)) DESC;

-- Have some fun with it now. Determine performance based on salary per efficiency. What are some conclusions you can draw.

SELECT firstName, lastName, position, team, salary23_24$ AS 'Salary', ROUND((AVGefficiency*gamesPlayed)) AS 'Total Efficiency', ROUND(( ROUND((AVGefficiency*gamesPlayed))/salary23_24$ ) * pow(10,6), 2 ) AS 'Efficiency/Salary Rating'
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
ORDER BY ROUND(( ROUND((AVGefficiency*gamesPlayed))/salary23_24$ ) * pow(10,6), 2 ) DESC;

# Anthony Edwards had the highest efficiency/salary rating by an outstanding margin. Almost 3 times as great as the next closest player, Lebron James.
# You could say he OUT-performed his contract.
# A reason for this maybe because, although he has great production whilst on the floor, he was only on the books for $9.2M this season.
# This salary will increase to 42.2 million dollars ath the start of the 24/25 season, after signing his extension 5yr/$244M extension in July 2023.
# With that salary, his rating would have been around 1.78, which is more similar to the others on the roster. It would put him 4th in the list, between Steph Curry and Bam Adebayo.
# Although Tyrese Haliburton had by far the worst efficiency, he also isn't getting paid a lot, relatively speaking compared to his teammates.
# However, like Edwards, he also has a 5yr/$244M extension which kicks this upcoming season. It would increase his salary to $42.2M.
# If he was on the books for this amount during the last season, his efficiency/salary rating would've plummeted drammatically to 0.19. Last by a country mile.
# This doesn't make Tyrese a bad player, he had the least amount of playing time during the tournament, and also made some light-hearted jokes concerning his contribution towards the Gold Medal.

-- Determine performance by points per minute.

SELECT firstName, lastName, position, AVGfgPct, AVG3pPct, AVGftPct, AVGpoints, AVGminsPlayed, (AVGpoints/AVGminsPlayed) AS 'Points per Minute'
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
ORDER BY (AVGpoints/AVGminsPlayed) DESC;

-- Compare the points, rebounds and assist total for players 30+ vs 29 and younger.

SELECT COUNT(teamusa.playerID) AS 'Players',
	CASE WHEN age >= 30 THEN '30 and older'
			ELSE '29 & younger'
            END AS 'AgeGroup',
SUM(ROUND(AVGpoints*gamesPlayed)) AS 'Total Points', SUM(ROUND(AVGrebounds*gamesPlayed)) AS 'Total Rebounds', SUM(ROUND(AVGassists*gamesPlayed)) AS 'Total Assists'
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
GROUP BY AgeGroup;

-- Is there a correlation between height and rebounds ?

SELECT firstName, lastName, position, heightFT, heightIN, ROUND(AVGrebounds*gamesPlayed) AS 'Total Rebounds', gamesPlayed
FROM stats
JOIN teamusa
ON stats.playerID = teamusa.playerID
ORDER BY ROUND(AVGrebounds*gamesPlayed) DESC;

# Generally the taller players grabbed the most rebounds
# 6 of the top 7 rebound totals are Forwards or Centers
# Steph Curry (6'2) amazingly had the same rebound total as Kevin Durant (6'10)

-- Coach Kerr and Coach Spoelstra agree that the two worst freethrow shooters gotta make 20 straight before sunset. Who has to participate ?

SELECT firstName, lastName, position, AVGftpct
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID
WHERE AVGftpct IS NOT NULL
ORDER BY AVGftPct ASC
LIMIT 2;

# Rolling Totals 'Partitioned' (Grouped)

SELECT firstName, lastName, position, AVGpoints, gamesPlayed, ROUND((gamesPlayed * AVGpoints)) AS 'Total Points', 
SUM(ROUND(AVGpoints * gamesPlayed)) OVER (PARTITION BY position ORDER BY AVGpoints DESC) AS 'Rolling Total Points By Position'
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID;

# Row Number

SELECT firstName, lastName, position, AVGpoints, gamesPlayed, ROUND((gamesPlayed * AVGpoints)) AS 'Total Points', 
ROW_NUMBER() OVER (PARTITION BY position ORDER BY AVGpoints DESC)
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID;

# RANK / DENSE_RANK

SELECT firstName, lastName, position, AVGpoints, gamesPlayed, ROUND((gamesPlayed * AVGpoints)) AS 'Total Points', 
RANK() OVER (PARTITION BY position ORDER BY AVGpoints DESC)
FROM teamusa
JOIN stats
ON teamusa.playerID = stats.playerID;