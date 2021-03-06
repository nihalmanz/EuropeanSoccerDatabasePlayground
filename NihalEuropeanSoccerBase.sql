-- Set up the home team CTE
with home as (
  SELECT m.id, t.team_long_name,
	  CASE WHEN m.home_team_goal > m.away_team_goal THEN 'MU Win'
		   WHEN m.home_team_goal < m.away_team_goal THEN 'MU Loss' 
  		   ELSE 'Tie' END AS outcome
  FROM matches AS m
  LEFT JOIN team AS t ON m.home_team_api_id = t.team_api_id),
-- Set up the away team CTE
away as (
  SELECT m.id, t.team_long_name,
	  CASE WHEN m.home_team_goal < m.away_team_goal THEN 'MU Win'
		   WHEN m.home_team_goal > m.away_team_goal THEN 'MU Loss' 
  		   ELSE 'Tie' END AS outcome
  FROM matches AS m
  LEFT JOIN team AS t ON m.away_team_api_id = t.team_api_id)
-- Select team names, the date and goals
SELECT DISTINCT
     m.date,
    home.team_long_name AS home_team,
    away.team_long_name AS away_team,
    m.home_team_goal,
    m.away_team_goal
-- Join the CTEs onto the match table
FROM matches AS m
LEFT JOIN home ON m.id = home.id
LEFT JOIN away ON m.id = away.id
WHERE m.season = '2014/2015'
      AND (home.team_long_name = 'Manchester United' 
           OR away.team_long_name = 'Manchester United');