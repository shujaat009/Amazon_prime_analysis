DROP TABLE IF EXISTS amazon;
CREATE TABLE amazon
(
UserID INTEGER,
Name VARCHAR(30),
Email_Address VARCHAR(40),
Username VARCHAR(30),
Date_of_Birth VARCHAR(15),
Gender VARCHAR(10),
Location VARCHAR(40),	
Membership_Start_Date VARCHAR(15),
Membership_End_Date VARCHAR(15),
Subscription_Plan VARCHAR(15),
Payment_Information VARCHAR(15),
Renewal_Status VARCHAR(15),
Usage_Frequency VARCHAR(15),
Purchase_History VARCHAR(15),
Favorite_Genres VARCHAR(15),
Devices_Used VARCHAR(15),
Engagement_Metrics VARCHAR(15),
Feedback_Ratings DECIMAL(3,2),
Customer_Support_Interactions INTEGER
) 

SELECT * FROM amazon;
SELECT renewal_status FROM amazon



--How many active users are there based on Renewal_Status?
SELECT renewal_status, COUNT(*) AS total_active_members 
FROM amazon
WHERE renewal_status = 'Auto-renew' AND usage_frequency = 'Frequent'
GROUP BY renewal_status;


--What is the gender distribution of Amazon Prime users?
SELECT gender, COUNT(*)
FROM amazon
WHERE gender = 'Male' OR gender = 'Female'
GROUP BY gender;


SELECT TO_CHAR(TO_DATE(date_of_birth, 'YYYY-MM-DD'), 'DD-MM-YYYY') AS date_of_birth
FROM amazon

UPDATE amazon
SET  date_of_birth = TO_CHAR(TO_DATE(date_of_birth, 'YYYY-MM-DD'), 'DD-MM-YYYY');

--Which age group (derived from Date_of_Birth) is the most active?

SELECT 
	CASE 
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, TO_DATE(date_of_birth, 'DD-MM-YYYY'))) BETWEEN 18 AND 25 THEN '18-25'
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, TO_DATE(date_of_birth, 'DD-MM-YYYY'))) BETWEEN 26 AND 35 THEN '26-35'
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, TO_DATE(date_of_birth, 'DD-MM-YYYY'))) BETWEEN 36 AND 45 THEN '36-45'
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, TO_DATE(date_of_birth, 'DD-MM-YYYY'))) > 45 THEN '46+'
		ELSE 'unknown'
	END AS age_group,
	SUM(
		CASE
			WHEN usage_frequency = 'Regular' THEN 1
			WHEN usage_frequency = 'Frequent' THEN 2
			WHEN usage_frequency = 'Occassional' THEN 3
			ELSE 0
		END 
		)AS total_activity,
	SUM(
		CASE 
			WHEN engagement_metrics = 'Low' THEN 1
			WHEN engagement_metrics = 'Medium' THEN 2
			WHEN engagement_metrics = 'High' THEN 3
			ELSE 0
		END
	) AS engagement_level
FROM amazon
GROUP BY age_group
ORDER BY total_activity DESC, engagement_level DESC

--What are the top 5 most common locations of users?

SELECT location,
	SUM(
		CASE
			WHEN usage_frequency = 'Regular' THEN 1
			WHEN usage_frequency = 'Frequent' THEN 2
			WHEN usage_frequency = 'Occassional' THEN 3
			ELSE 0
		END 
		)AS total_activity,
	SUM(
		CASE 
			WHEN engagement_metrics = 'Low' THEN 1
			WHEN engagement_metrics = 'Medium' THEN 2
			WHEN engagement_metrics = 'High' THEN 3
			ELSE 0
		END
	) AS engagement_level
FROM amazon
GROUP BY location
ORDER BY total_activity DESC, engagement_level DESC

--What are the usage patterns (Usage_Frequency) by gender and location?
SELECT gender, location,
	SUM(
		CASE
			WHEN usage_frequency = 'Regular' THEN 1
			WHEN usage_frequency = 'Frequent' THEN 2
			WHEN usage_frequency = 'Occassional' THEN 3
			ELSE 0
		END 
		)AS total_activity
FROM amazon
GROUP BY gender, location
ORDER BY total_activity DESC

--How many users joined Amazon Prime in each year (Membership_Start_Date)?
SELECT 
	EXTRACT(YEAR FROM TO_DATE(membership_start_date, 'YYYY-MM-DD')) as start_year
FROM amazon

--Which subscription plan (Subscription_Plan) is the most popular?

SELECT subscription_plan, 
	SUM(
		CASE
			WHEN usage_frequency = 'Regular' THEN 1
			WHEN usage_frequency = 'Frequent' THEN 2
			WHEN usage_frequency = 'Occassional' THEN 3
			ELSE 0
		END 
		)AS total_activity
FROM amazon
GROUP BY subscription_plan
ORDER BY total_activity DESC

--What is the distribution of users by Payment_Information (e.g., Credit Card, PayPal)?
SELECT DISTINCT payment_information 
FROM AMAZON

--What are the top 5 favorite genres (Favorite_Genres) among users?
SELECT favorite_genres,
	SUM(
		CASE 
			WHEN engagement_metrics = 'Low' THEN 1
			WHEN engagement_metrics = 'Medium' THEN 2
			WHEN engagement_metrics = 'High' THEN 3
			ELSE 0
		END
	) AS engagement_level
FROM AMAZON
GROUP BY favorite_genres
ORDER BY engagement_level

--How do Favorite_Genres vary by location or gender?
SELECT favorite_genres, location, gender,
	SUM(
		CASE 
			WHEN engagement_metrics = 'Low' THEN 1
			WHEN engagement_metrics = 'Medium' THEN 2
			WHEN engagement_metrics = 'High' THEN 3
			ELSE 0
		END
	) AS engagement_level
FROM AMAZON
GROUP BY location,gender,favorite_genres
ORDER BY engagement_level DESC

--What is the correlation between Purchase_History and Favorite_Genres?
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
    $$SELECT 
        purchase_history::TEXT,  
        favorite_genres,
        COUNT(*)::INTEGER AS genre_count  
    FROM amazon
    GROUP BY purchase_history, favorite_genres
    ORDER BY purchase_history, favorite_genres$$
) AS ct(
    purchase_history TEXT, 
    Action INTEGER,
    Comedy INTEGER,
    Drama INTEGER,
    Romance INTEGER,
    Documentary INTEGER,
    Horror INTEGER,
    Sci_Fi INTEGER
);

--What are the average engagement metrics (Engagement_Metrics) for different subscription plans?
SELECT 
	subscription_plan,
	AVG(
	CASE
		WHEN engagement_metrics = 'High' THEN 1
		WHEN engagement_metrics = 'Medium' THEN 2
		WHEN engagement_metrics = 'Low' THEN 3
		ELSE NULL
	END
	) AS average_engagement
FROM amazon
GROUP BY subscription_plan
ORDER BY average_engagement DESC

--Which devices (Devices_Used) are most commonly used to access Amazon Prime?
SELECT 
	devices_used,
	SUM(
		CASE
			WHEN usage_frequency = 'Regular' THEN 1
			WHEN usage_frequency = 'Frequent' THEN 2
			WHEN usage_frequency = 'Occasional' THEN 3
			ELSE NULL
		END 
	)AS total_frequency,
	SUM(
		CASE
			WHEN engagement_metrics = 'High' THEN 1
			WHEN engagement_metrics = 'Medium' THEN 2
			WHEN engagement_metrics = 'Low' THEN 3
			ELSE NULL
		END
	) AS total_engagement
FROM AMAZON
GROUP BY devices_used
ORDER BY total_frequency, total_engagement











 


