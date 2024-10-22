--Problem 1

SELECT
    job_title_short AS job_title,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AS job_posted_date_utc,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS job_posted_date_est
FROM
    job_postings_fact
LIMIT 20;

--Problem 2

SELECT
    EXTRACT(MONTH FROM job_posted_date) AS month,
    COUNT(job_title_short) AS job_count
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month
LIMIT 20;

--Problem 3

SELECT
    job_title_short AS job_title,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS job_posted_date_est
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist'
    AND job_posted_date BETWEEN '2023-01-01' AND '2023-06-30'
ORDER BY
    job_posted_date
LIMIT 20;

--Problem 7

SELECT
    EXTRACT(MONTH FROM job_posted_date) AS month,
    job_title_short AS job_title,
    COUNT(job_title_short) AS job_count
FROM
    job_postings_fact
WHERE
    job_title_short IN ('Data Engineer','Machine Learning Engineer')
GROUP BY
    EXTRACT(MONTH FROM job_posted_date),
    job_title_short
ORDER BY
    month, job_title;