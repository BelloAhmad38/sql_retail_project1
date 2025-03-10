--data cleaning
delete from retail_sales
where transactions_id 
in (
select transactions_id
from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or	
gender is null
or
category is null	
or
quantity is null
or
cogs is null	
or
total_sale is null

);

--no of sales
select count(transactions_id)
from retail_sales;


--no of custommers
select count(distinct customer_id)
from retail_sales;

--no of categories
select count(distinct category)
from retail_sales;

--need all data on sales made on 22-11-05
select *
from retail_sales
where sale_date = '2022-11-05';

--need all data where category is clothing and quantity is more than 10 in the month of nov-22
select *
from retail_sales
where category = 'Clothing'
and
quantity >= 4
and
sale_date between '2022-11-01' 
and '2022-11-30'
;

--need total sales for each category
select sum(total_sale), category
from retail_sales
group by category;

--need the average age of customers who purchased items from beauty

select round( avg(age))
from retail_sales
where category = 'Beauty';

--need all transactions where total sales is greater than 1k
select retail_sales.transactions_id, retail_sales.total_sale
from retail_sales
where total_sale > 1000;

--need total number 0f transactions made by each gender in each catgogry

select count(retail_sales.transactions_id) as total_trans, category, gender
from retail_sales
group by category, gender
order by gender
;

--need the average sale for each month. need best selling month
select round(avg(total_sale)) as sales, 
extract(year from sale_date) as year,
extract(month from sale_date) as month
from retail_sales
group by year, month
order by sales desc
;

--need the top five custoners based on sales
select sum(total_sale) as sales, customer_id
from retail_sales
group by customer_id
order by sales desc
limit 5
;

--need number of unique customers who purchased items from each category
select count(distinct customer_id) as coun, category
from retail_sales
group by category;

--need number of orders during each shift
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

--end of project