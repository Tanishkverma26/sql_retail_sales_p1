create table retail_sales (

-- SQL retail sales analysis - p1 
create database sql_sales_project;


-- Create TABLE 
CREATE TABLE retail_sales
		(
			transactions_id INT PRIMARY KEY ,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(15),
			age	INT,
			category VARCHAR(15),
			quantiy	INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
		)

-- DATA CLEANING --

select * from retail_sales
limit 10

select count(*) from retail_sales

select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null

select * from retail_sales
where 
		transactions_id is null or 
		sale_date is null or
		sale_time is null or 
		customer_id is null or
		gender is null or
		age is null or
		category is null or
		quantiy is null or
		price_per_unit is null or
		cogs is null or 
		total_sale is null 


delete from retail_sales
where 
	transactions_id is null or 
		sale_date is null or
		sale_time is null or 
		customer_id is null or
		gender is null or
		age is null or
		category is null or
		quantiy is null or
		price_per_unit is null or
		cogs is null or 
		total_sale is null 

-- DATA EXPLORATION -- 
select count(*) as total_sale from retail_sales

-- how many unique costumers we have 
select count(distinct customer_id) as total_sales from retail_sales

select distinct category from retail_sales

-- DATA ANALYSIS-- 

--Q1. write a sql query to retrieve all columns for sales made on 2022-11-05 
 select * 
 from retail_sales
 where sale_date = '2022-11-05'

 --q2. write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of november 2022
 select * 
 from retail_sales 
 where 
 category = 'clothing' 
 and 
 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
 and 
 quantiy >= 4

-- q3 write a SQL query to calculate the total sales (total_sale) for each categories
select 
	category, 
	sum(total_sale)as net_sale 
from retail_sales
group by 1 

-- q4 write a SQL query to find the average age of customers who purchased items from the 'beauty' category 
select 
round(avg(age))
from retail_sales
where category = 'Beauty'

--q5 write a SQL query to find all transations where the total_sale is greater than 1000
select * from retail_sales where total_sale > 1000

-- q6. write a SQL query to find the total number of transations made by each gender in each category 
select 
	category,
	gender,
	count(*) as total_trans
from retail_sales
group by 
	category,
	gender
order by 1

--q7 write a SQL query to calculate the avg sale for each month. find out the highest selling month 
select 
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale
from retail_sales
group by 1,2
order by 1,3 desc


--q8 write a sql query to find the top customers based on highest total sales

select 
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
group by 1
order by 1,2 desc 
limit 5

-- Q-9
select 
	category,
	count(DISTINCT customer_id) as cnt_unique_customer
from retail_sales
group by 1


--q10 write a SQL query to create each shift and number of orders (eg morning <12, afternoon = btw 12-15, evening - > 17 )
with hourly_sale as 
(select *,
	case 
		when extract(hour from sale_time) <12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)

select 
	shift,
	count(*) as total_orders
from hourly_sale
group by shift