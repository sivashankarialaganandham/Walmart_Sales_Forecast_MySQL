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

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------- Feature Engineering -------------------------------------------------------------

-- time_of_day
SELECT
	time,
    (CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
    ) AS time_of_date
FROM sales;

ALTER table sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"
	END
);

-- day_name
SELECT 
	date,
    DAYNAME(date)AS day_name
FROM sales;

ALTER table sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- month_name
SELECT 
	date,
    monthname(date)
FROM sales;

ALTER table sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = monthname(date);

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------- Generic Question -------------------------------------------------------------

-- How many unique cities does the data have?
SELECT 
	distinct city
FROM sales;

-- In which city is each branch?
SELECT 
	distinct branch
FROM sales;

SELECT 
	distinct city,
    branch
FROM sales;

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------- Product Question ----------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	count(distinct product_line)
FROM sales;

-- What is the most common payment method?
SELECT
	payment_method,
	count(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt desc;

-- What is the most selling product line?
SELECT
	product_line,
	count(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt desc;

-- What is the total revenue by month?
SELECT
	month_name as month,
    SUM(total) as total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue desc;

-- What month had the largest COGS?
SELECT
	month_name as MONTH,
    sum(cogs) as cogs
FROM sales
GROUP BY month_name
ORDER BY cogs desc;

-- What product line had the largest revenue?
SELECT
	product_line,
    sum(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue desc;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
    sum(total) as total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue desc;

-- What product line had the largest VAT?
SELECT
	product_line,
    avg(VAT) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax desc;

-- Which branch sold more products than average product sold?
SELECT 
	branch,
    SUM(quantity) as QTY
FROM sales
GROUP BY branch
HAVING sum(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT
	gender,
    product_line,
    count(gender) as total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY totaL_cnt desc;

-- What is the average rating of each product line?
SELECT
	round(avg(rating), 2) as avg_rating,
    product_line 
FROM sales
GROUP BY product_line
ORDER BY avg_rating desc;

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------- Sales Question ------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday
SELECT
	time_of_day,
    count(*) as total_sales
FROM sales
-- WHERE day_name = 'Monday'
GROUP BY time_of_day
ORDER BY total_sales desc;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
    sum(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue desc;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT
	city,
    avg(VAT) as VAT
FROM sales
GROUP BY city
ORDER BY VAT desc;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
    avg(VAT) as VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT desc;

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------- Customer Question ---------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT 
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT 
	DISTINCT payment_method
FROM sales;

-- Which customer type buys the most?
SELECT
    customer_type,
    count(*) as customer_count
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
    COUNT(*) as gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count desc;

-- What is the gender distribution per branch?
SELECT
	gender,
    COUNT(*) as gender_count
FROM sales
WHERE branch = "A"
GROUP BY gender
ORDER BY gender_count desc;

-- Which time of the day do customers give most ratings?
SELECT 
	time_of_day,
    AVG(rating) as avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating desc;

-- Which time of the day do customers give most ratings per branch?
SELECT 
	time_of_day,
    AVG(rating) as avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating desc;

-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
    AVG(rating) as avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating desc;

-- Which day of the week has the best average ratings per branch?
SELECT
	day_name,
    AVG(rating) as avg_rating
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY avg_rating desc;
