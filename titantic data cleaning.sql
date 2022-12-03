SELECT *
FROM PortfolioProjects..titanic

SELECT Title, Lastname, Firstname, Maidenname, sex, age, HomeCity, Destination, fare, Class, Port, ticket, cabin, Survival 
FROM PortfolioProjects..titanic

--USED CASE STATEMENT TO ADD A CITY NAME TO EMBARKED COLUMN INSTEAD OF INITIAL
SELECT 
Case	WHEN embarked = 'S' THEN 'Southhampton'
		WHEN embarked = 'Q' THEN 'Queenstown'
		WHEN embarked = 'C' THEN 'Cherbourg'
		ELSE ' '
END AS Port
FROM PortfolioProjects..titanic

--USED CASE STATEMENT TO CHANGE SURVIVE COLUMN TO YES/NO
SELECT 
Case	WHEN survived = '1' THEN 'Yes'
		WHEN survived = '0' THEN 'No'
		ELSE null
END AS Survival
FROM PortfolioProjects..titanic

--USE CASE STATEMENT TO LABEL CLASS FIRST, SECOND, OR THIRD
SELECT 
Case	WHEN pclass = '1' THEN 'First'
		WHEN pclass = '2' THEN 'Second'
		WHEN pclass = '3' THEN 'Third'
		ELSE null
End AS Class
FROM PortfolioProjects..titanic


--Separating Home#Dest column in two columns named HomeCity and Destination
--Used Declare statement for '/' to return null values for the destination in none was given
--Use case statement to find any row that had a '/' to return the HomeCity if given before the '/' 
-- Added a Replace query to remove '?' from the beginning of thr home#dest rows
DECLARE @SEARCHSTRING VARCHAR(50) = '/';
SELECT home#dest,
	Ltrim(Replace(SUBSTRING(home#dest,NULLIF(CHARINDEX(@SEARCHSTRING,home#dest), +0),LEN(home#dest)), '/', ' ')) as Destination,
  CASE 
     WHEN CHARINDEX('/', home#dest) > 0
     THEN SUBSTRING(home#dest, 1, CHARINDEX('/', home#dest)-1)
     ELSE  LTRIM(REPLACE(home#dest, '?', ' ' ))
  END AS HomeCity
FROM PortfolioProjects..titanic


--ADDED HomeCity, PORT, CLASS, DESTINATION, AND SURVIVAL COLUMNS TO TABLE
ALTER TABLE PortfolioProjects..titanic
ADD HomeCity VARCHAR (255), Port VARCHAR (255), Class VARCHAR (255), Destination VARCHAR (255), Survival VARCHAR (255);

--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED
UPDATE PortfolioProjects..titanic
SET 
PORT = CASE 
		WHEN embarked = 'S' THEN 'Southhampton'
		WHEN embarked = 'Q' THEN 'Queenstown'
		WHEN embarked = 'C' THEN 'Cherbourg'
		ELSE NULL
END 

--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED
UPDATE PortfolioProjects..titanic
SET
Survival = CASE
		WHEN survived = '1' THEN 'Yes'
		WHEN survived = '0' THEN 'No'
		ELSE null
END 

--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED
UPDATE PortfolioProjects..titanic
SET
Class =  Case	
		WHEN pclass = '1' THEN 'First'
		WHEN pclass = '2' THEN 'Second'
		WHEN pclass = '3' THEN 'Third'
		ELSE null
END

--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED
UPDATE PortfolioProjects..titanic
SET
HomeCity = CASE 
     WHEN CHARINDEX('/', home#dest) > 0
     THEN SUBSTRING(home#dest, 1, CHARINDEX('/', home#dest)-1)
     ELSE  LTRIM(REPLACE(home#dest, '?', ' ' ))
  END 

--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED
DECLARE @SEARCHSTRING VARCHAR(50) = '/';
UPDATE PortfolioProjects..titanic
SET 
Destination = 
Ltrim(Replace(SUBSTRING(home#dest,NULLIF(CHARINDEX(@SEARCHSTRING,home#dest), +0),LEN(home#dest)), '/', ' '))
		SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 
SELECT name, SUBSTRING(name, 1, CHARINDEX('.', name) -1) 
FROM PortfolioProjects..titanic

--REMOVED THE QUOTATION MARKS FROM ALL RECORDS IN THE NAME COLUMN
--CREATED A NEW COLUMN NAMED 'name2' AND ADDED THAT COLUMN TO THE TABLE
ALTER TABLE PortfolioProjects..titanic
ADD name2 VARCHAR(255);

UPDATE PortfolioProjects..titanic
SET 
name2 = REPLACE(name, '"', ' ')

--SEPARATED THE NAME COLUMN INTO 4 CONSISTING OF FIRSTNAME, LASTNAME, TITLE, AND MAIDENNAME
Select name, sex,
	PARSENAME(name2, 1) AS Firstname, 
	PARSENAME(Replace(name2, ',', '.') ,2) AS Title,
	SUBSTRING(name2, 1 , CHARINDEX(',', name2 )-1) AS Lastname,
	CASE
	WHEN CHARINDEX('(', name2) > 0
	THEN LTRIM(SUBSTRING(name2,CHARINDEX('(',name2)+1,(((LEN(name2))-CHARINDEX(')', REVERSE(name2)))-CHARINDEX('(',name2))))
	ELSE NULL
	END AS Maidenname
FROM PortfolioProjects..titanic

--ADDED 4 NEW COLUMNS TO TABLE
ALTER TABLE PortfolioProjects..titanic
ADD Firstname VARCHAR (255), Lastname VARCHAR (255), Title VARCHAR (50), Maidenname VARCHAR (255)

--UPDATED NEWLY CREATED COLUMNS WITH QUERIES USED TO SEPARTE NAME 'name2' COLUMN
UPDATE PortfolioProjects..titanic
SET
Title = PARSENAME(Replace(name2, ',', '.') ,2),
Firstname = PARSENAME(name2, 1),
Lastname = SUBSTRING(name2, 1 , CHARINDEX(',', name2 )-1),
Maidenname = CASE
	WHEN CHARINDEX('(', name2) > 0
	THEN LTRIM(SUBSTRING(name2,CHARINDEX('(',name2)+1,(((LEN(name2))-CHARINDEX(')', REVERSE(name2)))-CHARINDEX('(',name2))))
	ELSE NULL
	END











