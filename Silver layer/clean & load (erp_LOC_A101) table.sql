select * from silver.erp_LOC_A101

insert into silver.erp_LOC_A101(
cid,
cntry
)

select 
replace(cid, '-', '') cid,

case when trim(cntry) = 'DE' then 'Germany'
when trim(cntry) in ('US', 'USA') then 'United States'
when trim(cntry) = '' or cntry is null then 'n/a'
end as cntry

from bronze.erp_LOC_A101

-- check data standardization & consistency
select distinct cntry
from bronze.erp_LOC_A101
order by cntry
