/*Sales Analysis:

What are the top-selling products by revenue?*/


SELECT p.`Product type` AS product , SUM(s.`Revenue generated`) AS revenue 
FROM products p 
JOIN sales s ON p.SKU = s.SKU
GROUP BY product
ORDER BY revenue DESC;


/*Which product categories contribute the most to overall revenue?*/


WITH cte AS (SELECT  p.`Product type` AS product,
SUM(CASE WHEN p.`Product type` = 'skincare' THEN s.`Revenue generated`
WHEN p.`Product type` = 'haircare' THEN s.`Revenue generated`
WHEN p.`Product type` = 'cosmetics' THEN s.`Revenue generated` END) AS revenue,
(SELECT SUM(`revenue generated`) FROM sales) AS total_revenue
FROM products p JOIN sales s ON p.SKU = s.SKU
GROUP BY product)


  
SELECT product, ROUND((revenue/total_revenue)* 100,2) AS perc_revenue 
FROM cte
GROUP BY product
ORDER BY perc_revenue DESC;

/*What is the distribution of product preferences among different customer demographics, and are there any notable trends or patterns?*/

SELECT s.`Customer demographics`,p.`Product type`,COUNT(*) AS count_customers FROM sales s 
JOIN products p ON s.SKU = p.SKU
GROUP BY s.`Customer demographics`,p.`Product type`
ORDER BY s.`Customer demographics`, count_customers DESC



  
/*Inventory and Production:


Which products have the highest and lowest stock levels?*/


SELECT p.`Product type` as product, SUM(i.`Stock levels`) AS stock_levels
FROM products p
JOIN inventory i ON p.SKU = i.SKU
GROUP BY product 
ORDER BY stock_levels DESC;

/*How do lead times impact inventory levels?*/


SELECT i.`Lead times` AS lead_time, AVG(i.`Stock levels`) AS avg_stock_levels
FROM inventory i
GROUP BY i.`Lead times`
ORDER BY lead_time;


/*What is the defect rate for each product type, and how does it impact production volumes?*/



SELECT p.`Product type` AS product, SUM(i.`Defect rates`)/ COUNT(*) AS avg_defect_rate,
AVG(i.`Production volumes`) AS avg_production_volume 
FROM products p 
JOIN inventory i ON p.SKU = i.SKU
GROUP BY product
ORDER BY avg_defect_rate

/*Shipping and Transportation:

What are the average shipping times for different shipping carriers?*/

  

SELECT `Shipping carriers`, AVG(`shipping times`) AS avg_shipping_time
FROM shipping
GROUP BY `Shipping carriers`
ORDER BY avg_shipping_time;

/*Which transportation modes are the most cost-effective for different routes?*/



SELECT `Transportation modes`,Routes,ROUND(AVG(Costs),2) avg_cost 
FROM shipping
GROUP BY `Transportation modes`,Routes
ORDER BY Routes, avg_cost;

/*Can we optimize routes based on cost and shipping times?

yes we can optimize the routes, as our priority is speedy delivery and cost effective 
we can assign equal weights (these weights can be adjusted based on 
requirements (ex:- cost effective,speedy delivery or both) */



SELECT `Transportation modes`,Routes,AVG(Costs) avg_cost,
AVG(`Shipping times`) avg_ship_times,
ROUND((0.5 * AVG(`Shipping times`) + 0.5 * AVG(Costs)) / (0.5 +0.5),2) AS metric
FROM shipping
GROUP BY `Transportation modes`,Routes
ORDER BY metric

/*Supplier Performance:
  

Which suppliers have the shortest and longest lead times?*/

  
SELECT * FROM suppliers;

WITH cte AS(SELECT *,
ROW_NUMBER() OVER (PARTITION BY `Supplier name` ORDER BY `Lead time` DESC) as logest_time,
ROW_NUMBER() OVER (PARTITION BY `Supplier name` ORDER BY `Lead time` ) as shortest_time 
FROM suppliers)

  
SELECT `Supplier name`, 
MAX(CASE WHEN shortest_time = 1 THEN `Lead time` END) AS shortest_lead_time,
MAX(CASE WHEN logest_time = 1 THEN `Lead time` END) AS logest_lead_time
FROM cte
GROUP BY  `Supplier name`;


/*Are there any correlations between supplier locations and shipping costs?*/


SELECT su.Location,AVG(s.`Shipping costs`) as avg_shipping_cost
FROM suppliers su 
JOIN shipping s ON su.Location = s.Location
GROUP BY su.Location
ORDER BY avg_shipping_cost;
