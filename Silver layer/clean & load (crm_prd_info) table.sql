select * from silver.crm_prd_info
---------------------------------
insert into silver.crm_prd_info (
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt 

)
SELECT  
prd_id,  -- clean
REPLACE(substring(prd_key,1,5), '-', '_') as cat_id,
substring(prd_key,7,len(prd_key)) as prd_key,
prd_nm,
ISNULL(prd_cost, 0) as prd_cost,

case when UPPER(trim(prd_line)) = 'M' then 'Mountain'
when UPPER(trim(prd_line)) = 'R' then 'Road'
when UPPER(trim(prd_line)) = 'S' then 'Other Sales'
when UPPER(trim(prd_line)) = 'T' then 'Touring'
else 'n/a'
end as prd_line,

CAST(prd_start_dt as date),
CAST(LEAD(prd_start_dt) over (partition by prd_key order by prd_start_dt)-1 as date) as prd_end_dt

from bronze.crm_prd_info
where REPLACE(substring(prd_key,1,5), '-', '_') not in
(select distinct id from bronze.erp_PX_CAT_G1V2)

  -- check nor nulls or duplicates in primary key
  select
  prd_id,
  count(*)
  from bronze.crm_prd_info
  group by prd_id
  having count(*) >1 or prd_id is null

  -- 
  select prd_cost
  from bronze.crm_prd_info
  where prd_cost < 0 or prd_cost is null

  -- data standardization & consistency
  select distinct prd_line
  from bronze.crm_prd_info

  -- check for invalid date orders
  select *
  from bronze.crm_prd_info
  where prd_end_dt < prd_start_dt
