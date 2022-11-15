--Countries with highest infection percentage

SELECT 
	  location, 
	  population, 
	  MAX(total_cases) AS HighestInfectionCount, 
	  MAX((total_cases/population)) * 100 AS PercentofPopulationInfected
FROM PortfolioProjects..covid_deaths
	  GROUP BY location, population
	  order by 4 desc

--Percent of Positive Cases Deaths in United States

SELECT 
	  location,
	  date, 
	  population,
	  total_cases, 
	  total_deaths, 
	  (total_deaths/total_cases) * 100 AS PercentageofPosistivesDeaths
FROM PortfolioProjects..covid_deaths
WHERE location LIKE '%States%'
	  order by 1,3


--Highest Death Count by continent

Select 
	 location, 
	 MAX(total_deaths) AS TotalDeathCount
FROM PortfolioProjects..covid_deaths
WHERE continent is not NULL
	 GROUP BY location 
	 order by TotalDeathCount desc


--Death Total by continent in descending order  

SELECT continent, 
	SUM(CAST(new_deaths AS int)) AS TotalDeaths
FROM PortfolioProjects..covid_deaths
WHERE continent is not null AND total_deaths is not null
	GROUP BY continent
    order by TotalDeaths desc


--Table Join Covid deaths table with Covid vacinations table

SELECT *
FROM PortfolioProjects..covid_deaths dea
    JOIN PortfolioProjects..covid_vacinations vac
    ON dea.location = vac.location 
    and dea.date = vac.date   


--Worldwide infection & death rate of people with covid 19 in descending order  
	
Select location, 
	SUM(new_cases) AS PositiveCases
From PortfolioProjects..covid_deaths
	--Where continent in null
	--Where location like '%states%'
	Group By location
	Order by PositiveCases desc
	

--Total Positive Cases and Deaths

Select location, 
	SUM(new_cases) AS PositiveCases, 
	SUM(CAST(new_deaths AS INT)) AS Deaths
FROM PortfolioProjects..covid_deaths
WHERE location like 'World'
	Group By Location
	Order by 1

--Population with cases, vacination, and death rate

Select 
	dea.location, 
	MAX(vac.population) AS WorldPopulation, 
	SUM(dea.new_cases) AS PositiveCases,
	SUM(CAST(dea.new_deaths AS INT)) AS Deaths, 
	MAX(vac.people_vaccinated) AS Vacinated,
	SUM(CAST(dea.new_deaths AS INT))/SUM(dea.new_cases) * 100 AS DeathRate,
	MAX(vac.people_vaccinated/dea.population) * 100 AS VaxRate
FROM PortfolioProjects..covid_deaths dea
	Join PortfolioProjects..covid_vacinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.location like 'World'
	Group By dea.Location, vac.population
	Order by 1,2



--Infection Rate by continent in descending order  

SELECT 
	continent, 
	MAX(population) AS TotalPopulation, 
	MAX(total_cases) AS TotalCases, 
	MAX(total_cases)/MAX(population) * 100 AS InfectionRate
FROM PortfolioProjects..covid_deaths
WHERE continent is not null 
	GROUP BY continent 
	order by InfectionRate desc


--
  
--Percent of Country's population Infected in descending order    

SELECT 
	location, 
	population, 
	MAX(total_cases) AS HighestInfectionCount, 
	MAX((total_cases/population)) * 100 AS PercentofPopulationInfected
FROM PortfolioProjects..covid_deaths
	GROUP BY location, population
	order by 4 desc

--Countries with the highest percentage of people Vacinated

SELECT
	location,
	continent,
	population, 
	MAX(people_vaccinated) AS PeopleVacinated, 
	MAX(people_vaccinated/population) * 100 AS VaxRate
FROM PortfolioProjects..covid_vacinations vac
WHERE continent is not NULL 
	GROUP BY continent, location,population
	order by 5 desc


       

