select * from silver.erp_CUST_AZ12
----------------------------------
insert into silver.erp_CUST_AZ12(
cid,
bdate,
gen
)
select 

case when cid like 'NAS%' then SUBSTRING(cid, 4, len(cid))
else cid 
end cid,

case when bdate > GETDATE() then null
else bdate
end as bdate,

case when UPPER(TRIM(gen)) in ('F' , 'FEMALE') then 'Female' 
when UPPER(TRIM(gen)) in ('M' , 'MALE') then 'Male'
else 'n/a'
end as gen

from bronze.erp_CUST_AZ12
