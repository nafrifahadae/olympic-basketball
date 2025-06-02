# 🏀 Team USA Basketball SQL Analysis (2024 Olympics)

*Built with passion for sports, data, and SQL.*

## Overview

This SQL project explores the profiles and performance of the 2024 Team USA Men’s Olympic Basketball roster. It uses structured queries to analyse player stats, roster decisions, and salary-to-performance efficiency during the Olympic tournament and the 2023–24 NBA season.

The project was built using a custom SQL database (`olympicsBasketball`) with two core tables:
- `teamUSA`: Biographical and NBA performance data
- `Stats`: Player averages and totals over 6 Olympic games

## 🧱 Database Schema

### `teamUSA`
Stores player metadata and regular season information:
- `playerID`, `firstName`, `lastName`, `age`, `position`
- `heightFt`, `heightIn`, `weightLb`, `team`
- `regSeasonGamesPlayed`, `salary23_24$`

### `Stats`
Captures Olympic game performance metrics:
- `playerID` (FK)
- Minutes, Points, Rebounds, Assists, Steals, Blocks
- Shooting percentages (FG%, 3P%, FT%)
- Turnovers, Fouls, Plus/Minus, Efficiency

## 📊 Key Insights

### 🔄 Roster Change
- **Kawhi Leonard** was removed due to injury.
- **Derrick White** was controversially selected as a replacement, joining two other Celtics.

### 👶 Player Profiles
- Youngest player: **Anthony Edwards** (23)
- Tallest player: **Joel Embiid** (7'0")
- Players sorted by height, weight, and age groups.

### 📈 Statistical Leaders
- **LeBron James** won **Olympic MVP**
- Top PRA (Points + Rebounds + Assists): Curry, LeBron, Durant
- Highest 3P%: Devin Booker (56.5%)

### 💰 Salary Analysis
- Total Team Salary: ~$396.4M
- Average Salary: ~$33M
- Efficiency per $M spent highlighted huge value from **Anthony Edwards**

### 🔍 Advanced Queries
- Shooting splits by position (FG%, 3P%, FT%)
- Assist-to-turnover ratios
- Points per minute and performance by age group
- Efficiency-to-salary comparisons
- Window functions: `ROW_NUMBER`, `RANK`, `SUM OVER (PARTITION BY)`

### 🧠 Fun Observations
- Edwards massively outperformed his rookie-scale salary
- Steph Curry matched Durant’s total rebounds despite being 8 inches shorter
- Some players didn’t attempt a free throw the whole tournament!

## 🛠️ SQL Concepts Used
- Aggregate functions (`AVG`, `SUM`, `MIN`, `MAX`)
- `JOIN`s and Subqueries
- `CASE` statements
- Window functions: `OVER`, `PARTITION BY`, `RANK`
- Logical filtering (`LIKE`, `IS NULL`, `GROUP BY`, `HAVING`)
- Ordering and ranking data (`ORDER BY`, `LIMIT`)

## 🎯 Purpose & Learning Outcomes
- Practice advanced SQL query writing
- Analyse sports data to extract valuable insights
- Translate raw stats into meaningful comparisons
- Simulate real-world analyst tasks like player valuation and team profiling

## 🔮 Future Improvements
- Add visualisation (Power BI or Tableau)
- Introduce time series comparisons over Olympic games
- Expand to analyse other teams or previous tournaments
- Incorporate API for real-time stats updates

