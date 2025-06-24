-- Croma India product wise sales report for fiscal year 2021

/* As a product owner. I want to generate a report of individual product sales (aggregated on a monthly basis at the product level) for Amazon India customers for FY =2021 so that I can track individual product sales and run further product analytics on it in excel.
The report should have the following fields,
1. Month
2. Product Name & Variant
3. Sold Quantity
4. Gross Price Per Item
5. Gross Price Total
6. Variants */

Select 
		Month(s.date), s.product_code,
		p.product, p.variant, s.sold_quantity,
        g.gross_price,
        Round(g.gross_price*s.sold_quantity,2) as gross_price_total
from fact_sales_monthly s
Join dim_product p on p.product_code=s.product_code
Join fact_gross_price g on g.product_code=s.product_code and g.fiscal_year=get_fiscal_year(s.date)
where customer_code = 90002002 and get_fiscal_year(date)= 2021
order by date desc
limit 1000;

-- Gross monthly total sales report for Croma
/* As a product owner, I need an aggregate monthly gross sales report for Croma India customer so that I can track how much sales this particular customer is generating for AtliQ and manage our relationships accordingly.
The report should have the following fields,
1. Month
2. Total gross sales amount to Croma India in this month
*/

Select s.date, Round(SUM(g.gross_price*s.sold_quantity),2) as gross_price_total
from fact_sales_monthly s
join fact_gross_price g 
on g.fiscal_year=get_fiscal_year(s.date) and g.product_code=s.product_code
where customer_code = 90002002
group by s.date
order by s.date desc;

-- Generate a yearly report for Croma India where there are two columns
/*
1. Fiscal Year
2. Total Gross Sales amount In that year from Croma
*/

Select get_fiscal_year(s.date) as fiscal_year, SUM(g.gross_price*s.sold_quantity) as Total_Gross_Sales_amount
from fact_gross_price g
join fact_sales_monthly s
on g.fiscal_year=get_fiscal_year(s.date) and g.product_code=s.product_code
where customer_code = 90002002
group by fiscal_year;



