--use DataWarehouse
create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime;
	declare @batch_start_time datetime, @batch_end_time datetime;
	begin try
	set @batch_start_time = GETDATE();
	print '---------------------------';
	print '>> Loading Bronze Layer <<';
	print '---------------------------';
	print '----- Loading CRM Tables -----';
	set @start_time = GETDATE();
	print 'Truncating Table: bronze.crm_cust_info';
	truncate table bronze.crm_cust_info;
	PRINT 'Inserting Data Into: bronze.crm_cust_info';
	bulk insert bronze.crm_cust_info
	from'D:\1desc storage\DEPI 3\Technical session\week 12\project\datasets\source_crm\cust_info.csv'
	with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	set @end_time = GETDATE();
	print 'loading duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	print '------------------------------------------';
	
	set @start_time = GETDATE();
	print 'Truncating Table: bronze.crm_prd_info';
	truncate table bronze.crm_prd_info

	print 'Inserting Data Into: bronze.crm_prd_info';
	bulk insert bronze.crm_prd_info
	from'D:\1desc storage\DEPI 3\Technical session\week 12\project\datasets\source_crm\prd_info.csv'
	with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	set @end_time = GETDATE();
	print 'loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
	print '------------------------------------------';

	set @start_time = GETDATE();
	print 'Truncating Table: bronze.crm_sales_details';
	truncate table bronze.crm_sales_details;
	
	print 'Inserting Data Into: bronze.crm_sales_details';
	bulk insert bronze.crm_sales_details
	from'D:\1desc storage\DEPI 3\Technical session\week 12\project\datasets\source_crm\sales_details.csv'
	with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	set @end_time = GETDATE();
	print 'loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
	print '------------------------------------------';

	print '----- Loading ERP Tables -----';

	set @start_time = GETDATE();
	print 'Truncating Table: bronze.erp_CUST_AZ12';
	truncate table bronze.erp_CUST_AZ12

	print 'Inserting Data Into: bronze.erp_CUST_AZ12';
	bulk insert bronze.erp_CUST_AZ12
	from'D:\1desc storage\DEPI 3\Technical session\week 12\project\datasets\source_erp\CUST_AZ12.csv'
	with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	set @end_time = GETDATE();
	print 'loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
	print '------------------------------------------';

	set @start_time = GETDATE();
	print 'Truncating Table: bronze.erp_LOC_A101';
	truncate table bronze.erp_LOC_A101

	print 'Inserting Data Into: bronze.erp_LOC_A101';
	bulk insert bronze.erp_LOC_A101
	from'D:\1desc storage\DEPI 3\Technical session\week 12\project\datasets\source_erp\LOC_A101.csv'
	with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	set @end_time = GETDATE();
	print 'loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
	print '------------------------------------------';

	print'truncate table: bronze.erp_PX_CAT_G1V2'
	truncate table bronze.erp_PX_CAT_G1V2

	print 'inserting data into: bronze.erp_PX_CAT_G1V2';
	bulk insert bronze.erp_PX_CAT_G1V2
	from'D:\1desc storage\DEPI 3\Technical session\week 12\project\datasets\source_erp\PX_CAT_G1V2.csv'
	with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
	);
		set @end_time = GETDATE();
	print 'loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
	print '------------------------------------------';

	set @batch_end_time = GETDATE();
	print'------------------------------------'
	print'Loading Bronze Layer is Completed';
	print'>>>>> total load duration ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
	
	end try
	begin catch
		print 'Error occurde during loading bronze layer'
		print 'Error Message' + error_message();
		print 'Error Message' + cast (error_number() as nvarchar);
		print 'Error Message' + cast (error_state() as nvarchar);
	end catch
end
