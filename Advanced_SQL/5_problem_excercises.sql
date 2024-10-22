WITH q_one AS(
SELECT *
FROM january_jobs

UNION ALL

SELECT *
FROM february_jobs

UNION ALL

SELECT *
FROM march_jobs
)
SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date,
    salary_year_avg

FROM q_one
WHERE 
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT 20;


SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date,
    salary_year_avg

FROM
    (SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
    )
    AS quarter_1
WHERE 
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT 20;