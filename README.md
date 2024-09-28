# Walmart Sales Forecasting Data Analysis using MySQL

![Walmart Logo](https://github.com/sivashankarialaganandham/Walmart_Sales_Forecast_MySQL/blob/main/Walmart%20Logo.png)

## Overview 
This project aims to analyze Walmart's sales data to identify top-performing branches and products, track sales trends across different categories, and understand customer behavior. The goal is to explore how sales strategies can be optimized and improved. 

## Objectives
The primary objective of this project is to analyze Walmart's sales data to gain insights into the various factors influencing sales across different branches.
- __Product Analysis__: Analyze the data to identify top-performing product lines and those requiring improvement.
- __Sales Analysis__: Examine sales trends to assess the effectiveness of sales strategies and identify areas for optimization.
- __Customer Analysis__: Investigate customer segments, purchase patterns, and segment profitability to better understand customer behavior.

## Dataset
The data for this project is sourced from the Kaggle dataset:
- __Dataset Link__: [Walmart Sales Dataset](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/overview)

## Schema
```sql
CREATE DATABASE IF NOT EXISTS WalmartSalesData;

CREATE TABLE IF NOT EXISTS sales(
	invoice_id varchar(30) NOT NULL PRIMARY KEY,
    branch varchar(5) NOT NULL,
    city varchar(30) NOT NULL,
    customer_type varchar(30) NOT NULL,
    gender varchar(10) NOT NULL,
    product_line varchar(100) NOT NULL,
    unit_price decimal(10, 2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6, 4) NOT NULL,
    total decimal(12, 4) NOT NULL,
    date datetime NOT NULL,
    time time NOT NULL,
    payment_method varchar(15) NOT NULL,
    cogs decimal (10, 2) NOT NULL,
    gross_margin_percentage float(11, 9),
    gross_income decimal (12, 4) NOT NULL,
    rating float(2, 1)
);
```

## General Questions and Solutions

### 1. How many unique cities does the data have?
```sql
SELECT 
	distinct city
FROM sales;
```

### 2. Which city is in each branch?
```sql
SELECT 
	distinct branch
FROM sales;

SELECT 
	distinct city,
    branch
FROM sales;
```

## Product Questions and Solutions

### 1. How many unique product lines does the data have?
```sql
SELECT
	count(distinct product_line)
FROM sales;
```

### 2. What is the most common payment method?
```sql
SELECT
	payment_method,
	count(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt desc;
```

### 3. What is the most selling product line?
```sql
SELECT
	product_line,
	count(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt desc;
```

### 4. What is the total revenue by month?
```sql
SELECT
	month_name as month,
    SUM(total) as total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue desc;
```

### 5. What month had the largest COGS?
```sql
SELECT
	month_name as MONTH,
    sum(cogs) as cogs
FROM sales
GROUP BY month_name
ORDER BY cogs desc;
```

### 6. What product line had the largest revenue?
```sql
SELECT
	product_line,
    sum(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue desc;
```

### 7. What is the city with the largest revenue?
```sql
SELECT
	branch,
	city,
    sum(total) as total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue desc;
```

### 8. What product line had the largest VAT?
```sql
SELECT
	product_line,
    avg(VAT) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax desc;
```

### 9. Which branch sold more products than average product sold?
```sql
SELECT 
	branch,
    SUM(quantity) as QTY
FROM sales
GROUP BY branch
HAVING sum(quantity) > (SELECT AVG(quantity) FROM sales);
```

### 10. What is the most common product line by gender?
```sql
SELECT
	gender,
    product_line,
    count(gender) as total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY totaL_cnt desc;
```

### 11: What is the average rating of each product line?
```sql
SELECT
	round(avg(rating), 2) as avg_rating,
    product_line 
FROM sales
GROUP BY product_line
ORDER BY avg_rating desc;
```

## Sales Questions and Solutions

### 1. Number of sales made in each time of the day per weekday
```sql
SELECT
	time_of_day,
    count(*) as total_sales
FROM sales
-- WHERE day_name = 'Monday'
GROUP BY time_of_day
ORDER BY total_sales desc;
```

### 2. Which of the customer types brings the most revenue?
```sql
SELECT
	customer_type,
    sum(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue desc;
```

### 3. Which city has the largest tax percent/ VAT (Value Added Tax)?
```sql
SELECT
	city,
    avg(VAT) as VAT
FROM sales
GROUP BY city
ORDER BY VAT desc;
```

### 4. Which customer type pays the most in VAT?
```sql
SELECT
	customer_type,
    avg(VAT) as VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT desc;
```

## Customer Questions and Solutions

### 1. How many unique customer types does the data have?
```sql
SELECT 
	DISTINCT customer_type
FROM sales;
```

### 2. How many unique payment methods does the data have?
```sql
SELECT 
	DISTINCT payment_method
FROM sales;
```

### 3. Which customer type buys the most?
```sql
SELECT
    customer_type,
    count(*) as customer_count
FROM sales
GROUP BY customer_type;
```

### 4. What is the gender of most of the customers?
```sql
SELECT
	gender,
    COUNT(*) as gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count desc;
```

### 5. What is the gender distribution per branch?
```sql
SELECT
	gender,
    COUNT(*) as gender_count
FROM sales
WHERE branch = "A"
GROUP BY gender
ORDER BY gender_count desc;
```

### 6. Which time of the day do customers give most ratings?
```sql
SELECT 
	time_of_day,
    AVG(rating) as avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating desc;
```

### 7. Which time of the day do customers give most ratings per branch?
```sql
SELECT 
	time_of_day,
    AVG(rating) as avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating desc;
```

### 8. Which day fo the week has the best avg ratings?
```sql
SELECT
	day_name,
    AVG(rating) as avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating desc;
```

### 9. Which day of the week has the best average ratings per branch?
```sql
SELECT
	day_name,
    AVG(rating) as avg_rating
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY avg_rating desc;
```

## Code
For the complete code, kindly check out the [Walmart Sales Data.sql]()file.
