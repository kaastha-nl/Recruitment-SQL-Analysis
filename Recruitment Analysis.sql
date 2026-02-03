use dsba;
SELECT * FROM recruitment_dataset;
SELECT DISTINCT * FROM recruitment_dataset LIMIT 5;
DESCRIBE recruitment_dataset;
ALTER TABLE recruitment_dataset RENAME COLUMN `ind-degree` TO ind_degree;
ALTER TABLE recruitment_dataset RENAME COLUMN `ind-programming_exp` TO ind_programming_exp;
ALTER TABLE recruitment_dataset RENAME COLUMN `ind-university_grade` TO ind_university_grade;

# Overall hiring rate (core KPI)
SELECT COUNT(*) AS total_candidates, SUM(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) AS hired,
  ROUND(AVG(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) * 100, 2) AS hiring_rate_pct FROM recruitment_dataset;
  
# Hiring rate by company
SELECT company, COUNT(*) AS candidates, SUM(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) AS hired,
  ROUND(AVG(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) * 100,2) AS hiring_rate_pct
  FROM recruitment_dataset GROUP BY company ORDER BY hiring_rate_pct DESC;

# Hiring rate by degree
SELECT ind_degree AS degree, COUNT(*) AS candidates, ROUND(AVG(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) * 100,2) AS hiring_rate_pct
FROM recruitment_dataset GROUP BY ind_degree ORDER BY hiring_rate_pct DESC;

# Programming experience vs hiring
SELECT ind_programming_exp AS programming_experience, COUNT(*) AS candidates, ROUND(AVG(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) * 100,2) AS hiring_rate_pct
FROM recruitment_dataset GROUP BY ind_programming_exp;

# University grade impact
SELECT ind_university_grade AS university_grade, COUNT(*) AS candidates, ROUND(AVG(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) * 100,2) AS hiring_rate_pct
FROM recruitment_dataset GROUP BY ind_university_grade ORDER BY university_grade DESC;

# Observable differences by gender
SELECT gender, COUNT(*) AS candidates, ROUND(AVG(CASE WHEN decision = 'True' THEN 1 ELSE 0 END) * 100,2) AS hiring_rate_pct
FROM recruitment_dataset GROUP BY gender;
