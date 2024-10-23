# Introduction
In depth analysis focusing in on the data job market. Specifically, my analysis is focused on Data Scientists, seeking to explore the most demanded skills and best paying skills offered to Data Scientists working remotely. 

To check out my SQL queries check them out here: [project_sql folder](/project_sql/)

# Background
The motivation behind this analysis is to better understand the data job market. With this analysis, I would be able to make data-driven decisions on what skills would be most profitable for me to invest time into. 

The data used in my analysis is from the following source: [SQL Course](https://lukebarousse.com/sql). This data goes into great detail, discussing job locations, salaries, and essential skills for 2023.
### The questions that this analysis intended to answer were:

1. What are the top-paying Data Scientist jobs?
2. What skills are required for the top-paying jobs?
3. What skills are most in demand for Data Scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used
For my analysis I used the following tools:
- **SQL:** The foundation of my analysis, used to query the database and uncover key insights.
- **PostgreSQL:** Database management system used throughout the steps of my project. 
- **Visual Studio Code:** Used for both database management and SQL query execution.
- **Git & GitHub:** Used for the sharing of my SQL scripts and overarching analysis, allowing for effective project tracking
# The Analysis
Each one of my queries aimed at answering the corresponding questions for my analysis found in the Background. They all aimed to explain the workings of the Data Scientist job market.
### 1. Top Paying Data Scientist Jobs
This query involved filtering out Data Scientist average yearly salary as well as their location, focussing on remote jobs. The query highlights high paying opportunities within the field.

**Code Used:**
```sql
SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
| Job Title                                  | Company Name       | Salary (Yearly Avg) | Job Location | Posted Date         |
|--------------------------------------------|--------------------|---------------------|--------------|---------------------|
| Staff Data Scientist/Quant Researcher       | Selby Jennings      | $550,000            | Anywhere     | 2023-08-16 16:05:16 |
| Staff Data Scientist - Business Analytics   | Selby Jennings      | $525,000            | Anywhere     | 2023-09-01 19:24:02 |
| Data Scientist                              | Algo Capital Group  | $375,000            | Anywhere     | 2023-07-31 14:05:21 |

*Sample of the generated output for the highest paying jobs for Data Scientists working remotely (2023).*

**Key insights:**

- **High Salaries for Specialized Roles:** The highest-paying job is a Staff Data Scientist/Quant Researcher at Selby Jennings, offering $550,000, showing that roles combining data science and quantitative research are in high demand.

- **Executive and Leadership Roles:** Positions like Head of Data Science and Director of Data Science offer significant salaries, ranging from $300,000 to $351,500, highlighting the value of leadership in data science.

- **Staff-Level Roles Remain Lucrative:** Companies are offering high salaries (up to $525,000) for senior-level technical roles like Staff Data Scientist, reflecting the demand for skilled individual contributors. 
### 2. Top Paying Data Scientist Skills
In this part of the analysis, I take the input from the previous section, focussing on the top paying jobs, and use CTEs to find out, given the top paying jobs, what are the skills associated with them?

**Code Used:**
```sql
WITH top_paying_jobs AS(
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills
FROM    
    top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
| Job Title                                  | Company Name       | Salary (Yearly Avg) | Skills  |
|--------------------------------------------|--------------------|---------------------|---------|
| Staff Data Scientist/Quant Researcher       | Selby Jennings      | $550,000            | sql     |
| Staff Data Scientist/Quant Researcher       | Selby Jennings      | $550,000            | python  |
| Staff Data Scientist - Business Analytics   | Selby Jennings      | $525,000            | sql     |
| Data Scientist                              | Algo Capital Group  | $375,000            | sql     |

*Sample of the generated output for the skills associated with the highest paying jobs for Data Scientists working remotely (2023).*

**Key insights:**

- **SQL and Python are Key Skills:** The highest-paying Data Scientist roles, such as Staff Data Scientist and Quant Researcher, consistently list SQL and Python as essential skills, indicating their critical importance in high-paying positions.

- **Selby Jennings Dominates Top Salaries:** The highest-paying roles are concentrated at Selby Jennings, offering up to $550,000 for Staff Data Scientist roles, with both SQL and Python skills being highly valued.

- **Versatility in Skills Increases Pay:** Top-paying roles require a combination of programming languages like SQL, Python, and Java, showing that proficiency in multiple technologies increases earning potential for Data Scientists.
### 3. Top Demanded Data Scientist Skills
In this part of the analysis, I sought to look further into the skills in highest demand for Data Scientists. 

**Code Used:**
```sql
SELECT 
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
| Skills  | Demand Count |
|---------|--------------|
| Python  | 10,390       |
| SQL     | 7,488        |
| R       | 4,674        |
| AWS     | 2,593        |
| Tableau | 2,458        |

*Generated output for the highest demanded skills for Data Scientists working remotely (2023).*

**Key Insights:**

- **Python Leads in Demand:** With over 10,000 mentions, Python is the most sought-after skill, reinforcing its role as a foundational programming language for data science tasks.

- **SQL is Highly Valuable:** SQL, with a demand count of 7,488, remains critical for data manipulation and querying, making it the second most essential skill for remote Data Scientists.

- **Growing Need for Cloud and Visualization Tools:** Skills in AWS (2,593 mentions) and Tableau (2,458 mentions) highlight the increasing demand for cloud computing and data visualization expertise, as remote data science work often involves large-scale data management and reporting.
### 4. Top Paying Data Scientist Skills
In this part of the analysis, I turn my attention now to the skills that correspond with the highest average salary for Data Scientists working remotely. 

**Code Used:**
```sql
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
```
| Skills        | Average Salary ($) |
|---------------|--------------------|
| GDPR          | 217,737.50          |
| Golang        | 208,750.00          |
| Atlassian     | 189,700.00          |
| Selenium      | 180,000.00          |
| OpenCV        | 172,500.00          |
| Neo4j         | 171,655.00          |
| MicroStrategy | 171,146.58          |
| DynamoDB      | 169,670.33          |

*Sample of the generated output for the skills associated with the highest average salaries for Data Scientists working remotely (2023).*

**Key Insights:**
- **Back-End Development & DevOps:** Data Scientists who are skilled in programming languages like Golang,
Rust, and Elixir, alongside tools like Airflow, DynamoDB, and Redis, are highly valued, indicating that companies prioritize the ability to build and manage scalable, real-time systems.

- **Privacy and Compliance Expertise:** The dominance of GDPR shows that companies are willing to pay a premium for data scientists with expertise in regulatory compliance,which is especially important for remote work in cross-border data-sharing environments.

- **Demand for Advanced BI & Machine Learning Tools:** Skills in BI (Qlik, MicroStrategy) and machine learning automation (DataRobot, Hugging Face) are rewarded,highlighting the importance of advanced data analysis, visualization, and machine learning capabilities.
### 5. Most Optimal Data Scientist Skills
In this part of the analysis, I use my findings from the skills most demanded by companies for Data Scientists working remotely, as well as the skills that have the highest average salary for Data Scientists working remotely. I combine my findings to decide the most optimal skills for Data Scientists to learn. 

**Code Used:**
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10 
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| Skill ID | Skills    | Demand Count | Average Salary ($) |
|----------|-----------|--------------|--------------------|
| 26       | C         | 48           | 164,864.98          |
| 8        | Go        | 57           | 164,691.09          |
| 187      | Qlik      | 15           | 164,484.64          |
| 185      | Looker    | 57           | 158,714.91          |
| 96       | Airflow   | 23           | 157,414.13          |
| 77       | BigQuery  | 36           | 157,142.36          |
| 3        | Scala     | 56           | 156,701.92          |
| 81       | GCP       | 59           | 155,810.57          |

*Sample of the generated output for the optimal skills for Data Scientists working remotely to learn (2023).*

**Key Insights:**
- **C and Go Are High-Paying and In-Demand:** Skills like C and Go offer average salaries of approximately $165,000 while maintaining solid demand counts (48 and 57, respectively). These languages are both high-paying and have consistent demand, making them valuable for data scientists to focus on.

- **Looker and Airflow Are Highly Valued in Data Science:** Tools like Looker and Airflow offer competitive salaries around $158,000 and $157,000, respectively, and also meet significant demand thresholds (both have over 20 job postings). These are tools worth investing in for remote data science positions.

- **Big Data Skills Like BigQuery and Scala Remain Relevant:** BigQuery and Scala, with average salaries above $156,000 and demand counts above 35, are highly relevant in the data science field. Big data management and programming languages are consistently offering strong pay for those with expertise.

# What I learnt
- **Complex SQL Queries:** A lot of my queries revolved around using subqueries or CTEs as well as JOINS to branch between all the data available. This has helped me call on data from other tables more effectively and efficiently.
- **Data Job Market Insights:** I learnt a lot about both the skills that are in high demand for Data Scientist as well as those that are the best paid skills, allowing me to effectively plan out what skills I should choose to learn next. 
- **Data Aggregation:** Many times throughout my analysis, I had to use aggregate functions such as COUNT() and AVG() to effectively summarize my data.

# Conclusions
### Key insights from each section of analysis:
1. **High Salaries for Specialized Roles:** The highest-paying job is a Staff Data Scientist/Quant Researcher at Selby Jennings, offering $550,000, showing that roles combining data science and quantitative research are in high demand.

2. **SQL and Python are Key Skills:** The highest-paying Data Scientist roles, such as Staff Data Scientist and Quant Researcher, consistently list SQL and Python as essential skills, indicating their critical importance in high-paying positions.

3. **Python Leads in Demand:** With over 10,000 mentions, Python is the most sought-after skill, reinforcing its role as a foundational programming language for data science tasks.

4. **Back-End Development & DevOps:** Data Scientists who are skilled in programming languages like Golang,
Rust, and Elixir, alongside tools like Airflow, DynamoDB, and Redis, are highly valued, indicating that companies prioritize the ability to build and manage scalable, real-time systems.

5. **C and Go Are High-Paying and In-Demand:** Skills like C and Go offer average salaries of approximately $165,000 while maintaining solid demand counts (48 and 57, respectively). These languages are both high-paying and have consistent demand, making them valuable for data scientists to focus on.

### Closing Thoughts

Throughout my analysis, I have uncovered what are the most valuable skills to learn as a Data Scientist working remotely in 2023. The process of this analysis has helped strengthen my skills in using SQL, whether through sourcing data, aggregating it, or combining tables within my summarizations. Overall, I am confident that all of the tools I used throughout this analysis have helped me come to a conclusion on what I believe are the most valuable skills for a Data Scientist to invest in.