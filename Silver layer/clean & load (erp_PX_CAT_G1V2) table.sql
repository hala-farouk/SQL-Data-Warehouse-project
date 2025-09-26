select * from silver.erp_PX_CAT_G1V2
-----------------------------------------
truncate  table silver.erp_PX_CAT_G1V2
-----------------------------------------
insert into silver.erp_PX_CAT_G1V2
(
id,
cat,
subcat,
maintenance
)
select
id,
cat,
subcat,
maintenance
from bronze.erp_PX_CAT_G1V2

-- check for unwated spaces
select * from bronze.erp_PX_CAT_G1V2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance)

-- check data standardization & consistency
select distinct cat
from bronze.erp_PX_CAT_G1V2
----------------------
select distinct subcat
from bronze.erp_PX_CAT_G1V2
------------------------
select distinct maintenance
from bronze.erp_PX_CAT_G1V2
