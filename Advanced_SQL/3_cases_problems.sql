-- Problem 1

SELECT
    CASE
        WHEN salary_year_avg < 50000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High' 
    END AS salary_category,
    COUNT(job_id) AS number_of_jobs
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    salary_category
ORDER BY    
    number_of_jobs DESC;

-- Problem 5

SELECT
    CASE
        WHEN job_no_degree_mention = '0' THEN 'Degree Required'
        ELSE 'No Degree Mentioned'
    END AS degree_category,
    COUNT(job_id) AS number_of_jobs
FROM
    job_postings_fact
WHERE   
    job_no_degree_mention IS NOT NULL
GROUP BY
    degree_category
ORDER BY
    number_of_jobs DESC;
