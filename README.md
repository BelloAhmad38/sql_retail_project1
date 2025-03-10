# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. --need all data on sales made on 22-11-05
```sql
select *
from retail_sales
where sale_date = '2022-11-05';
```

2. --need all data where category is clothing and quantity is more than 10 in the month of nov-22

```sql
select *
from retail_sales
where category = 'Clothing'
and
quantity >= 4
and
sale_date between '2022-11-01' 
and '2022-11-30'
;

```

3.--need total sales for each category
```sql
select sum(total_sale), category
from retail_sales
group by category;
```

4. --need the average age of customers who purchased items from beauty
```sql
select round( avg(age))
from retail_sales
where category = 'Beauty';
```

5. --need all transactions where total sales is greater than 1k
```sql
select retail_sales.transactions_id, retail_sales.total_sale
from retail_sales
where total_sale > 1000;
```

6. --need total number 0f transactions made by each gender in each catgogry
```sql
select count(retail_sales.transactions_id) as total_trans, category, gender
from retail_sales
group by category, gender
order by gender
;
```

--need the average sale for each month. need best selling month
```sql
select round(avg(total_sale)) as sales, 
extract(year from sale_date) as year,
extract(month from sale_date) as month
from retail_sales
group by year, month
order by sales desc
;

```

8.--need the top five custoners based on sales
```sql
select sum(total_sale) as sales, customer_id
from retail_sales
group by customer_id
order by sales desc
limit 5
;
```

9. --need number of unique customers who purchased items from each category
```sql
select count(distinct customer_id) as coun, category
from retail_sales
group by category;
```

10. --need number of orders during each shift
```sql
select count(transactions_id) as orders,
case 
when extract(hour from sale_time) < 12
then 'Morning'
when extract(hour from sale_time) between 12 and 17
then 'Afternoon'
else 'evening'
end as shift
from retail_sales
group by shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.



