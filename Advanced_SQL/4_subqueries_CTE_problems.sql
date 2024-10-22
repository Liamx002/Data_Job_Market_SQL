-- Problem 1

SELECT
    name AS company_name
FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

-- Problem 2

WITH home_jobs AS( 
    SELECT
        company_id,
        AVG(salary_year_avg) AS average_salary
    FROM 
        job_postings_fact
    WHERE 
        job_work_from_home = true
    GROUP BY
        company_id)
SELECT 
    company_dim.name AS company_name,
    home_jobs.average_salary
FROM home_jobs
LEFT JOIN company_dim
    ON company_dim.company_id = home_jobs.company_id;

-- Problem 3

SELECT
    name AS company_name
FROM
    company_dim
WHERE
    company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE 
        job_health_insurance = true
        AND job_work_from_home = true);

-- Problem 4

WITH job_hire AS(

    SELECT
        COUNT(job_id) AS total_jobs,
        company_id
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT
    company_dim.name AS company_name,
    job_hire.total_jobs
FROM 
    company_dim
LEFT JOIN job_hire
    ON job_hire.company_id = company_dim.company_id
WHERE 
    job_hire.total_jobs IS NOT NULL
ORDER BY
    job_hire.total_jobs DESC;