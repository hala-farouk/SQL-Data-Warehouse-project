select * from silver.crm_sales_details
----------------------------------------
insert into silver.crm_sales_details(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
select
sls_ord_num,
sls_prd_key,
sls_cust_id,

case 
when sls_order_dt = 0 or LEN(sls_order_dt)!= 8 then null
else CAST(cast(sls_order_dt as varchar) as date)
end as sls_order_dt,

case 
when sls_ship_dt = 0 or LEN(sls_ship_dt)!= 8 then null
else CAST(cast(sls_ship_dt as varchar) as date)
end as sls_ship_dt,

case 
when sls_due_dt = 0 or LEN(sls_due_dt)!= 8 then null
else CAST(cast(sls_due_dt as varchar) as date)
end as sls_due_dt,


case
when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity * ABS(sls_price)
then sls_quantity * ABS(sls_price)
else sls_sales
end as sls_sales,

sls_quantity,

case when sls_price is null or sls_price <= 0
then sls_sales / nullif(sls_quantity, 0)
else sls_price
end as sls_price

from bronze.crm_sales_details 


-- check for invalid data
select
nullif(sls_order_dt,0) sls_order_dt

from bronze.crm_sales_details
where sls_order_dt <= 0 or LEN(sls_order_dt)!= 8 or sls_order_dt > 20500101
