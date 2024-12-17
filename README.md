# Amazon Prime Data Analysis

This repository contains an analysis of Amazon Prime user data with insights on user behavior, engagement, and preferences. The analysis is based on a dataset containing various attributes, such as user demographics, subscription details, payment methods, and content consumption patterns.

## Key Analysis Questions

The analysis addresses the following questions:

1. **How many active users are there based on Renewal_Status?**
   - We analyze the renewal status of users to identify how many users have active (Manual or Auto-renew) subscriptions.

2. **What is the gender distribution of Amazon Prime users?**
   - The gender distribution of users is calculated to understand the gender split among subscribers.

3. **Which age group (derived from Date_of_Birth) is the most active?**
   - We extract the age of users based on their date of birth and correlate activity levels with age groups.

4. **What are the top 5 most common locations of users?**
   - This analysis provides insights into the geographical distribution of Amazon Prime users.

5. **What are the usage patterns (Usage_Frequency) by gender and location?**
   - We examine how frequently users access Amazon Prime, segmented by gender and location.

6. **How many users joined Amazon Prime in each year (Membership_Start_Date)?**
   - This analysis shows the growth of Amazon Prime over time based on the membership start date.

7. **Which subscription plan (Subscription_Plan) is the most popular?**
   - We analyze which subscription plans (e.g., Monthly, Annual) are most preferred by users.

8. **What is the distribution of users by Payment_Information (e.g., Credit Card, PayPal)?**
   - We look at the distribution of payment methods used by users to subscribe to Amazon Prime.

9. **How do Favorite_Genres vary by location or gender?**
   - This analysis investigates the correlation between users' favorite genres and their gender or location.

10. **What is the correlation between Purchase_History and Favorite_Genres?**
    - We explore whether users' purchase history correlates with their favorite genres on Amazon Prime.

11. **What are the average engagement metrics (Engagement_Metrics) for different subscription plans?**
    - We calculate the average engagement levels for users based on their subscription plan type.

12. **Which devices (Devices_Used) are most commonly used to access Amazon Prime?**
    - This analysis identifies the most popular devices used by Amazon Prime users for streaming content.

## Data Sources

The analysis is based on the following dataset:

- **amazon.csv**: A CSV file containing Amazon Prime user data, including columns like `UserID`, `Gender`, `Location`, `Subscription_Plan`, `Payment_Information`, `Date_of_Birth`, `Usage_Frequency`, `Favorite_Genres`, and more.

## Technologies Used

- **SQL (PostgreSQL)**: For querying and aggregating data.
- **Data Analysis & Visualization**: To gain insights into user behaviors, such as location, age, subscription plan preferences, etc.
