SELECT *
FROM PortfolioProjects..titanic


--ADDED  PORT, CLASS,  AND SURVIVAL COLUMNS TO TABLE
ALTER TABLE PortfolioProjects..titanic
ADD  Port VARCHAR (255), Class VARCHAR (255), Survival VARCHAR (255);


--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED AND
--USED CASE STATEMENT TO ADD A CITY NAME TO EMBARKED COLUMN INSTEAD OF INITIAL
UPDATE PortfolioProjects..titanic
SET 
PORT = CASE 
		WHEN embarked = 'S' THEN 'Southhampton'
		WHEN embarked = 'Q' THEN 'Queenstown'
		WHEN embarked = 'C' THEN 'Cherbourg'
		ELSE NULL
END 

--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED
--AND USED CASE STATEMENT TO CHANGE SURVIVE COLUMN TO YES/NO
UPDATE PortfolioProjects..titanic
SET
Survival = CASE
		WHEN survived = '1' THEN 'Yes'
		WHEN survived = '0' THEN 'No'
		ELSE null
END 

--UPDATED NEWLY ADDED COLUMNS WITH THE RESULTS OF QUERIES PERFOMED
--AND USE CASE STATEMENT TO LABEL CLASS FIRST, SECOND, OR THIRD
UPDATE PortfolioProjects..titanic
SET
Class =  Case	
		WHEN pclass = '1' THEN 'First'
		WHEN pclass = '2' THEN 'Second'
		WHEN pclass = '3' THEN 'Third'
		ELSE null
END


--ADDED 5 NEW COLUMNS TO TABLE
ALTER TABLE PortfolioProjects..titanic
ADD name2 VARCHAR(255), Title VARCHAR (50), Lastname VARCHAR (255), Firstname VARCHAR (255),  Maidenname VARCHAR (255)

--REMOVED " MARKS FROM STRINGS IN NAME COLUMN
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


--SELECTED THE FIRST NAME FROM THE MAIDENNAME COLUMN SO IT CAN BE ADD TO THE USED IN THE THE FIRSTNAME COLUMN
--ADDED A SPACE AT THE END OF THE MAIDENNAME COLUMN SO I COULD THEM USE CODE TO EXTRACT THE 1ST NAME OF EACH STRING
UPDATE PortfolioProjects..titanic 
SET Maidenname = Maidenname +' '


UPDATE PortfolioProjects..titanic
SET Maidenname = SUBSTRING(Maidenname, 1, CHARINDEX(' ', Maidenname))


--ADDED A SPACE AT THE END OF THE FIRSTNAME COLUMN SO I COULD THEM USE CODE TO EXTRACT THE 1ST NAME OF EACH STRING
UPDATE PortfolioProjects..titanic
SET Firstname = Firstname +' '

--EXTRACTED THE 1ST WORD IN THE COLUMN STRING TO BE USED AS THEIR FIRSTNAME
SELECT Firstname, SUBSTRING(Firstname, 1, CHARINDEX(' ', LTRIM(Firstname))) AS Firstname1 
FROM PortfolioProjects..titanic


--UPDATED FIRSTNAME COLUMN TO USE THE 1ST WORD OF THE STRING AS FIRSTNAME
UPDATE PortfolioProjects..titanic 
SET Firstname = SUBSTRING(Firstname, 1, CHARINDEX(' ', LTRIM(Firstname)))


SELECT *
FROM PortfolioProjects..titanic


--UPDATED THE FIRSTNAME COLUMN TO INCLUDE THE FIRSTNAME OF FEMALE PASSENGERS WHO WERE REFERED TO BY THEIR HUSBANDS FIRSTNAME

ALTER TABLE PortfolioProjects..titanic
ADD first varchar(255)

UPDATE PortfolioProjects..titanic
SET
first = CASE 
	WHEN Maidenname IS NOT NULL AND sex = 'female'
	THEN SUBSTRING(Maidenname, 1, CHARINDEX(' ', Maidenname)) 
	ELSE Firstname
END 
 

UPDATE PortfolioProjects..titanic
SET Survival = LTRIM(Survival), Firstname = LTRIM(Firstname)


--ROUNDED THE AGE COLUMN TO REMOVE DECIMALS
UPDATE PortfolioProjects..titanic
SET age = ROUND(age, 0)


--Query of the columns that were cleaned
SELECT 
	Class,
	Title,
	Lastname,
	Firstname,
	Survival,
	sex,
	age,
	Port
FROM PortfolioProjects..titanic

