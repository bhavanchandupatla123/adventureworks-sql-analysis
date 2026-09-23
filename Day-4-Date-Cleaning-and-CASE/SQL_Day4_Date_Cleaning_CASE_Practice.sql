select orderdate
from factinternetsales
where OrderDate is not null
	and trim(OrderDate)<>''
    and str_to_date(orderdate,'%d/%m/%Y %H:%i') is null;
    
create table factsales as
select * from factinternetsales;

select count(*) from factinternetsales;

select count(*) from factsales;

select shipdate from factinternetsales
where shipdate is not null
	and trim(shipdate)<>''
    and str_to_date(shipdate,'%d/%m/%Y %H:%i') is null;
    
alter table factinternetsales
add column orderdate_new datetime ,
add column shipdate_new datetime;



set SQL_SAFE_UPDATES = 0;

update factinternetsales 
set orderdate_new = str_to_date(nullif(trim(orderdate),''), '%d/%m/%Y %H:%i'),
shipdate_new = str_to_date(nullif(trim(shipdate),''), '%d/%m/%Y %H:%i');


set SQL_SAFE_UPDATES = 1;

select count(*) as total_count,
COUNT(OrderDate_new) as converted_order_dates,
COUNT(ShipDate_new) as converted_ship_dates,
MIN(OrderDate_new) as earliest_order_date,
MAX(OrderDate_new) as latest_order_date from factinternetsales;


select date_format(orderdate_new,'%Y-%m') as sales_month,
	round(sum(salesamount),2) as total_sales
    from factinternetsales
where orderdate_new >='2013-01-01' and OrderDate_new < '2014-01-01'
group by date_format(orderdate_new,'%Y-%m')
order by sales_month;

select salesordernumber,orderdate_new,shipdate_new,
	datediff(shipdate_new,orderdate_new) as shipping_days,
case 
	when shipdate_new is null then 'not shipped'
 when datediff(shipdate_new,orderdate_new)<0 then 'invalid'
 when datediff(shipdate_new,orderdate_new)<=3 then 'fast'
 when datediff(shipdate_new,orderdate_new)<=7 then 'on time'
 else 'delayed' end as shipping_status    
from factinternetsales
limit 20;
	
    
SELECT
    COUNT(DISTINCT SalesOrderNumber) AS total_orders,

    COUNT(
        DISTINCT CASE
            WHEN ShipDate_new IS NULL
            THEN SalesOrderNumber
        END
    ) AS not_shipped_orders,

    COUNT(
        DISTINCT CASE
            WHEN DATEDIFF(ShipDate_new, OrderDate_new) < 0
            THEN SalesOrderNumber
        END
    ) AS invalid_orders,

    COUNT(
        DISTINCT CASE
            WHEN DATEDIFF(ShipDate_new, OrderDate_new) BETWEEN 0 AND 3
            THEN SalesOrderNumber
        END
    ) AS fast_orders,

    COUNT(
        DISTINCT CASE
            WHEN DATEDIFF(ShipDate_new, OrderDate_new) BETWEEN 4 AND 7
            THEN SalesOrderNumber
        END
    ) AS on_time_orders,

    COUNT(
        DISTINCT CASE
            WHEN DATEDIFF(ShipDate_new, OrderDate_new) > 7
            THEN SalesOrderNumber
        END
    ) AS delayed_orders

FROM factinternetsales;

SELECT
    DATEDIFF(ShipDate_new, OrderDate_new) AS shipping_days,
    COUNT(DISTINCT SalesOrderNumber) AS unique_orders
FROM factinternetsales
GROUP BY DATEDIFF(ShipDate_new, OrderDate_new)
ORDER BY shipping_days;


select date_format(orderdate_new,'%Y-%m') as sales_month,
count(distinct salesordernumber) as total_unique_orders,
round(sum(salesamount),2) as total_sales,
round(avg(datediff(shipdate_new,orderdate_new)),2) as average_shipping_days,
count(distinct case when datediff(shipdate_new,orderdate_new) between 4 and 7
		then salesordernumber end) as on_time_unique_orders,
round(100.0*count(
				distinct case when datediff(shipdate_new,orderdate_new) between 4 and 7
		then salesordernumber end )/ nullif(count(distinct salesordernumber),0),2)
			as on_time_percentage from factinternetsales
where orderdate_new >= '2013-01-01' and orderdate_new < '2014-01-01'
group by date_format(orderdate_new,'%Y-%m')
order by sales_month;

