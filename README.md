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
