CREATE DATABASE IF NOT EXISTS ADVENTURE_WORKS;

use ADVENTURE_WORKS;

create table Fact_Internet_Sales(
ProductKey	int,
OrderDateKey int,
DueDateKey	int, 
ShipDateKey	int,
CustomerKey	int,
PromotionKey int,
CurrencyKey	 int,
SalesTerritoryKey int,
SalesOrderNumber varchar(100),
SalesOrderLineNumber int,	
RevisionNumber	int,
OrderQuantity	int,
UnitPrice	decimal(15,2),
ExtendedAmount	decimal(15,2),
UnitPriceDiscountPct int,
DiscountAmount	int,
ProductStandardCost	decimal(15,2),
TotalProductCost decimal(15,2),
SalesAmount	decimal(15,2),
TaxAmt	decimal(15,2),
Freight	decimal(15,2),
OrderDate date,
DueDate	date,
ShipDate date
);

select * from Fact_Internet_Sales;


create table Fact_Internet_Sales_New(
ProductKey	int,
OrderDateKey int,
DueDateKey	int,
ShipDateKey int,	
CustomerKey	int,
PromotionKey int,
CurrencyKey	int,
SalesTerritoryKey int,
SalesOrderNumber varchar(100),	
SalesOrderLineNumber int,
RevisionNumber int,	
OrderQuantity int,	
UnitPrice decimal(15,2),	
ExtendedAmount decimal(15,2),	
UnitPriceDiscountPct int,
DiscountAmount	int,
ProductStandardCost	decimal(15,2),
TotalProductCost decimal(15,2),	
SalesAmount	decimal(15,2),
TaxAmt	decimal(15,2),
Freight	decimal(15,2),
OrderDate date,
DueDate date,	
ShipDate date
);		

select * from Fact_Internet_Sales_New;


create table DimSalesTerritory(
SalesTerritoryKey int,
SalesTerritoryAlternateKey int,
SalesTerritoryRegion varchar(50),	
SalesTerritoryCountry varchar(50),	
SalesTerritoryGroup varchar(50)
);

select * from DimSalesTerritory;

create table DimProductSubCategory(
ProductSubcategoryKey int,
ProductSubcategoryAlternateKey int,	
EnglishProductSubcategoryName varchar(250),	
SpanishProductSubcategoryName varchar(250),
FrenchProductSubcategoryName varchar(250),	
ProductCategoryKey int
);

select * from DimProductSubCategory;

create table DimProductCategory(
ProductCategoryKey int,
ProductCategoryAlternateKey int,
EnglishProductCategoryName varchar(50),	
SpanishProductCategoryName varchar(50),	
FrenchProductCategoryName varchar(50)
);

select * from DimProductCategory;


CREATE TABLE DimProduct (
ProductKey int,
ProductAlternateKey varchar(250),	
EnglishProductName	varchar(250),
SpanishProductName	varchar(250),
FrenchProductName varchar(250),
StandardCost   VARCHAR(50),
FinishedGoodsFlag varchar(50),
Color varchar(50),	
SafetyStockLevel int,
ReorderPoint int,
ListPrice varchar(100),
Size varchar(50),
SizeRange	varchar(50),
DaysToManufacture int,	
ProductLine varchar(50),
DealerPrice varchar(50),	
Class varchar(50),
Style varchar(50),	
ModelName varchar(250),
StartDate date,
status_ varchar(50)
);


select * from dimproduct;
SELECT COUNT(*) FROM adventure_works.dimproduct;


CREATE TABLE DimDate (
    DateKey                 INT             NOT NULL,
    FullDateAlternateKey    DATE,
    DayNumberOfWeek         INT,
    EnglishDayNameOfWeek    VARCHAR(20),
    SpanishDayNameOfWeek    VARCHAR(20),
    FrenchDayNameOfWeek     VARCHAR(20),
    DayNumberOfMonth        INT,
    DayNumberOfYear         INT,
    WeekNumberOfYear        INT,
    EnglishMonthName        VARCHAR(20),
    SpanishMonthName        VARCHAR(20),
    FrenchMonthName         VARCHAR(20),
    MonthNumberOfYear       INT,
    CalendarQuarter         INT,
    CalendarYear            INT,
    CalendarSemester        INT,
    FiscalQuarter           INT,
    FiscalYear              INT,
    FiscalSemester          INT
);

select * from DimDate;


CREATE TABLE DimCustomer (
    CustomerKey             INT             NOT NULL,
    GeographyKey            INT,
    CustomerAlternateKey    VARCHAR(20),
    Title                   VARCHAR(10),
    FirstName               VARCHAR(50),
    MiddleName              VARCHAR(50),
    LastName                VARCHAR(50),
    NameStyle               VARCHAR(50),
    BirthDate               VARCHAR(50),
    MaritalStatus           VARCHAR(5),
    Suffix                  VARCHAR(10),
    Gender                  VARCHAR(5),
    EmailAddress            VARCHAR(100),
    YearlyIncome            INT,
    TotalChildren           INT,
    NumberChildrenAtHome    INT,
    EnglishEducation        VARCHAR(50),
    SpanishEducation        VARCHAR(50),
    FrenchEducation         VARCHAR(50),
    EnglishOccupation       VARCHAR(50),
    SpanishOccupation       VARCHAR(50),
    FrenchOccupation        VARCHAR(50),
    HouseOwnerFlag          varchar(50),
    NumberCarsOwned         INT,
    AddressLine1            VARCHAR(255),
    AddressLine2            VARCHAR(255),
    Phone                   VARCHAR(20),
    DateFirstPurchase       varchar(20),
    CommuteDistance         VARCHAR(20),
    customer_full_name      VARCHAR(100)
);

select * from dimcustomer;


# Question 0 #

create table sales
select * from fact_internet_sales
union all
select * from fact_internet_sales_new;

select * from sales;


# Question 1 #

select * from dimproduct;

# Add column to the sales #
alter table sales 
add column EnglishProductName varchar(250);

# using joins, update EnglishProductName column #
update sales as s
join dimproduct as p on s.ProductKey = p.ProductKey
set s.EnglishProductName = p.EnglishProductName;

select * from sales;

# Question 2 #

select * from dimcustomer;

# Add the customer_full_name column #
ALTER TABLE dimcustomer
ADD COLUMN customer_full_name varchar(100);

update dimcustomer 
set customer_full_name = concat(FirstName," ", MiddleName," ", Lastname);

select * from dimcustomer;
select * from sales;

# Adding the customer_full_name column to the sales table #
alter table sales
add column customer_full_name varchar(100);

# By using joins, updating the customer_full_name from dimcustomer to sales table #
update sales as s
join dimcustomer as c on s.CustomerKey = c.CustomerKey
set s.customer_full_name = c.customer_full_name;

select * from sales;


# Question 3(a)#

-- Extract year --
alter table sales
add column year int;

update sales
set year = year(OrderDate);

select year from sales;

# 3(b) #

-- Extract month number --
alter table sales
add column month_no int;

update sales
set month_no = month(OrderDate);


# 3(c) #

-- Extract month_name --
alter table sales
add column month_name varchar(30);

update sales
set month_name = monthname(OrderDate);

select * from sales;


# 3(d) #

-- Extract quarter --
alter table sales
add column Quarter varchar(10);

update sales
set Quarter = concat("Q", quarter(OrderDate));


# 3(e) #

-- Extract Year_Month --
alter table sales
add column year_month_name varchar(50);

update sales
set year_month_name = concat(year(orderdate), '-', monthname(orderdate));


# 3(f) #

-- Extract weekday_num --
alter table sales
add column weekday_num int;

update sales
set weekday_num = dayofweek(OrderDate);

select * from sales;


# 3(g) #

-- Extract weekday_name --
alter table sales
add column weekday_name varchar(50);

update sales
set weekday_name = dayname(OrderDate);

# 3(h) #

-- Extract financial_month--
alter table sales
add column financial_month int;

update sales as s
set financial_month = case
    WHEN MONTH(OrderDate) = 4  THEN 1
    WHEN MONTH(OrderDate) = 5  THEN 2
    WHEN MONTH(OrderDate) = 6  THEN 3
    WHEN MONTH(OrderDate) = 7  THEN 4
    WHEN MONTH(OrderDate) = 8  THEN 5
    WHEN MONTH(OrderDate) = 9  THEN 6
    WHEN MONTH(OrderDate) = 10  THEN 7
    WHEN MONTH(OrderDate) = 11  THEN 8
    WHEN MONTH(OrderDate) = 12  THEN 9
    WHEN MONTH(OrderDate) = 1  THEN 10
    WHEN MONTH(OrderDate) = 2  THEN 11
    WHEN MONTH(OrderDate) = 3  THEN 12
END;

select * from sales;


# 3(i) #

-- Extract financial_quarter--
alter table sales
add column financial_quarter varchar(50);

update sales  as s
set financial_quarter = case
 WHEN MONTH(OrderDate) IN (4, 5, 6)    THEN 'FQ1'
 WHEN MONTH(OrderDate) IN (7, 8, 9)    THEN 'FQ2'
 WHEN MONTH(OrderDate) IN (10, 11, 12) THEN 'FQ3'
 WHEN MONTH(OrderDate) IN (1, 2, 3)    THEN 'FQ4'
END;


# Question 4 #

-- calculation of sales amount --
alter table sales
add column sales_amount int;

update sales as s
set sales_amount = (OrderQuantity * UnitPrice)*(1-DiscountAmount);

select sales_amount from sales;
select * from sales;


# Question 5 #

-- Calculation of production cost --
alter table sales
add column production_cost decimal(15,2);

update sales
set production_cost = ProductStandardCost * Orderquantity ;

select production_cost from sales;
select * from sales;

# Question 6 #

-- calculation of profit --
alter table sales
add column profit decimal(15,2);

update sales
set profit = sales_amount - production_cost;

select * from sales;

# Added columns in the sales table #
select 
Customer_full_name,
EnglishProductName,
UnitPrice,
year,
month_no,
month_name,
Quarter,
year_month_name,
weekday_num,
weekday_name,
financial_month,
financial_quarter,
sales_amount,
production_cost,
profit
from sales;

# 7 - month_sales #

select month_name,
concat(sum(sales_amount), " M") as Month_sales
from sales
group by  month_no, month_name
order by month_no;


# Year and Month_wise sales #

select 
year, month_no, month_name,
concat(sum(sales_amount), " M") as Monthly_sales,
sum(sales_amount) over(partition by year) as yearly_sales
from sales
group by year, month_no, month_name
order by year, month_no;

SET GLOBAL sql_mode = '';
SET SESSION sql_mode = '';


# 8 - year_wise_Total_sales # 

select year,
concat(sum(sales_amount), " M")as Year_wise_sales
from sales
group by year
order by year;


# 9 - Month_wise sales #

select month_no, month_name,
concat(sum(sales_amount), " M ")as Total_sales
from sales
group by month_no, month_name
order by month_no;


# 10 - Quarter_wise sales #

select Quarter,
concat(sum(sales_amount), " M")  as Total_sales
from sales
group by Quarter
order by Quarter;


# 12 - KPI #

-- Total_Sales --
select concat(sum(sales_amount)," M") as Total_sales from sales;

-- Total_Profit --
select concat(sum(profit), " M") as Total_profit from sales;

-- Total_Quantity --
select concat(sum(OrderQuantity), " M") as Total_Quantity from sales;

-- Total_Production
select concat(sum(production_cost), "M") as Total_production from sales;

-- Average_order_value_per_customer --
select concat(sum(sales_amount) / count(distinct(SalesOrderNumber))," M") as Avg_order_value from sales;



# Performace by Product #

select * from sales;

-- Top 10 product by sales--
select EnglishProductName,
concat(sum(sales_amount), " M ") as Total_sales
from sales
group by EnglishProductName
order by sum(sales_amount) desc
limit 10;


# Performance by region #

-- Region_wise sales --
select * from dimsalesterritory;
select * from sales;

select SalesTerritoryRegion,
concat(sum(sales_amount), " M") as Total_sales
from sales as s
join dimsalesterritory as t on s.SalesTerritoryKey = t.SalesTerritoryKey
group by SalesTerritoryRegion
order by sum(sales_amount) desc;


## Performance by Profit ##

-- Top-10 product  by profit --
select EnglishProductName,
concat(sum(profit), " M") as Total_profit
from sales
group by EnglishProductName
order by sum(profit) desc
limit 10;


# Performance by customer # 

-- Top 10 customer by sales --
select * from dimcustomer;
select * from sales;

select customer_full_name,
concat(sum(sales_amount), " M") as Total_sales
from sales as s
group by customer_full_name
order by sum(sales_amount) desc
limit 10;


# Profit by country #

select * from dimsalesterritory;
select * from sales;

select SalesTerritoryCountry,
concat(sum(profit)," M") as Total_Profit
from sales as s
join dimsalesterritory as t on s.SalesTerritoryKey = t.SalesTerritoryKey
group by SalesTerritoryCountry
order by sum(profit) desc;


# Profit by Region #

select * from dimsalesterritory;
select * from sales;

select SalesTerritoryRegion,
concat(round(sum(profit),2), " M") as Total_profit
from sales as s
join dimsalesterritory as t on s.SalesTerritoryKey = t.SalesTerritoryKey 
group by SalesTerritoryRegion
order by sum(profit) desc;






