SELECT TOP 10 *
FROM dbo.[SQL - Retail Sales Analysis_utf];
SELECT
	COUNT(*)
FROM dbo.[SQL - Retail Sales Analysis_utf];
--To check for the null values
SELECT *
FROM dbo.[SQL - Retail Sales Analysis_utf]
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL;
	--Delete all the null values
	DELETE 
	FROM dbo.[SQL - Retail Sales Analysis_utf]
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL;
SELECT *
FROM  dbo.[SQL - Retail Sales Analysis_utf]
--Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM  dbo.[SQL - Retail Sales Analysis_utf]
WHERE sale_date = '2022-11-05'
--Write a SQL query to retrieve all transactions where the category is 'Clothing' & the quantity sold is more than 4 in the month of Nov 2022?
SELECT * FROM dbo.[SQL - Retail Sales Analysis_utf]
WHERE category = 'Clothing' 
       AND quantiy >=4
	   AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
--Write a SQL query to calculate total_sales for each category?
SELECT
category,
SUM(total_sale) AS total_sales
FROM dbo.[SQL - Retail Sales Analysis_utf]
GROUP BY category
ORDER BY total_sales DESC
--Write a SQL query to calculate the average age of customers who purchased items from the 'Beauty' category?
SELECT 
AVG(age) AS avg_age
FROM dbo.[SQL - Retail Sales Analysis_utf]
WHERE category = 'Beauty'
--Write a SQL query to find all transactions where the total_sale is greater than 1000?
SELECT *
FROM dbo.[SQL - Retail Sales Analysis_utf]
WHERE total_sale > 1000
--Write a SQL query to find the total number of transactions(transactions_id) made by each gender in each category?
SELECT 
category,gender,
COUNT(transactions_id) AS total_no_of_transactions
FROM dbo.[SQL - Retail Sales Analysis_utf]
GROUP BY category,gender
ORDER BY category
--Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year?
SELECT 
year,month, avg_sale,rank
FROM (
SELECT 
YEAR(sale_date) AS year,
MONTH(sale_date) AS month,
AVG(total_sale) AS avg_sale,
RANK() OVER(PARTITION BY year(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM dbo.[SQL - Retail Sales Analysis_utf]
GROUP BY YEAR(sale_date),
MONTH(sale_date)) t
WHERE rank = 1
--Write a SQL query to find the top 5 customers based on the highest total sales?
SELECT TOP 5 
customer_id,
SUM(total_sale) AS total_sale
FROM dbo.[SQL - Retail Sales Analysis_utf]
GROUP BY customer_id
ORDER BY total_sale DESC
--Write a SQL query to find the number of unique customers who purchased items from each category?
SELECT 
COUNT(DISTINCT(customer_id)) AS cnt_unique_cs
catgory
FROM dbo.[SQL - Retail Sales Analysis_utf]
GROUP BY category
--Write a SQL query to create each shift and number of orders(Example - Morning <= 12, Afternoon Between 12 & 17,Evening > 17)
WITH hourly_sales AS (
SELECT *,
	 CASE 
			WHEN DATEPART(HOUR,sale_time) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
	 END AS shift
FROM dbo.[SQL - Retail Sales Analysis_utf]
)
SELECT
shift,
COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift
SELECT *
FROM dbo.[SQL - Retail Sales Analysis_utf]