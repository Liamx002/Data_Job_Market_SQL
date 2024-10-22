/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Scientist positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Scientists and
helps identify the most financially rewarding skills to acquire or improve
*/


SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 30;

/*
- Back-End Development & DevOps: Data Scientists who are skilled in programming languages like Golang,
Rust, and Elixir, alongside tools like Airflow, DynamoDB, and Redis, are highly valued, 
indicating that companies prioritize the ability to build and manage scalable, real-time systems.

- Privacy and Compliance Expertise: The dominance of GDPR shows that companies are willing to pay a premium for data scientists with expertise in regulatory compliance,
 which is especially important for remote work in cross-border data-sharing environments.

- Demand for Advanced BI & Machine Learning Tools: Skills in BI (Qlik, MicroStrategy) and machine learning automation (DataRobot, Hugging Face) are rewarded,
 highlighting the importance of advanced data analysis, visualization, and machine learning capabilities.

[
  {
    "skills": "gdpr",
    "average_salary": "217737.50"
  },
  {
    "skills": "golang",
    "average_salary": "208750.00"
  },
  {
    "skills": "atlassian",
    "average_salary": "189700.00"
  },
  {
    "skills": "selenium",
    "average_salary": "180000.00"
  },
  {
    "skills": "opencv",
    "average_salary": "172500.00"
  },
  {
    "skills": "neo4j",
    "average_salary": "171655.00"
  },
  {
    "skills": "microstrategy",
    "average_salary": "171146.58"
  },
  {
    "skills": "dynamodb",
    "average_salary": "169670.33"
  },
  {
    "skills": "php",
    "average_salary": "168125.00"
  },
  {
    "skills": "tidyverse",
    "average_salary": "165512.50"
  },
  {
    "skills": "solidity",
    "average_salary": "165000.00"
  },
  {
    "skills": "c",
    "average_salary": "164864.98"
  },
  {
    "skills": "go",
    "average_salary": "164691.09"
  },
  {
    "skills": "datarobot",
    "average_salary": "164500.00"
  },
  {
    "skills": "qlik",
    "average_salary": "164484.64"
  },
  {
    "skills": "redis",
    "average_salary": "162500.00"
  },
  {
    "skills": "watson",
    "average_salary": "161710.00"
  },
  {
    "skills": "elixir",
    "average_salary": "161250.00"
  },
  {
    "skills": "rust",
    "average_salary": "161250.00"
  },
  {
    "skills": "cassandra",
    "average_salary": "160850.00"
  },
  {
    "skills": "looker",
    "average_salary": "158714.91"
  },
  {
    "skills": "slack",
    "average_salary": "158333.33"
  },
  {
    "skills": "terminal",
    "average_salary": "157500.00"
  },
  {
    "skills": "airflow",
    "average_salary": "157414.13"
  },
  {
    "skills": "julia",
    "average_salary": "157243.80"
  },
  {
    "skills": "bigquery",
    "average_salary": "157142.36"
  },
  {
    "skills": "scala",
    "average_salary": "156701.92"
  },
  {
    "skills": "hugging face",
    "average_salary": "156519.83"
  },
  {
    "skills": "node.js",
    "average_salary": "156107.00"
  },
  {
    "skills": "vue",
    "average_salary": "156107.00"
  }
]
*/