/*
==================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==================================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external csv files
It performs the following actions:
-Truncates the bronze tables before loading data.
-Uses the BULK INSERT tables before loading data from csv files to bronze tables.

Parameters:
  None.
This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
====================================================================================================
*/
create or alter procedure bronze.load_bronze as 
BEGIN
DECLARE @starttime DATETIME, @endtime DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME;
  SET @batch_start_time= GETDATE();
	BEGIN TRY
		PRINT '=============================================';
		PRINT 'Loading bronze layer';
		PRINT '=============================================';

		PRINT '---------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '---------------------------------------------';

	SET @starttime =GETDATE();
		PRINT '>>Truncating table bronze.crm_cust_info>>';
			TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting into bronze.crm_cust_info>>';

			BULK INSERT bronze.crm_cust_info

			from 'C:\Users\PC\Desktop\sql-ultimate-course\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
SET @endtime =GETDATE();

PRINT '>>load time duration is ' + CAST(DATEDIFF(second, @starttime,@endtime) AS NVARCHAR) + ' seconds'
PRINT '>>-------------'

SET @starttime =GETDATE();

		PRINT '>>Truncating table bronze.crm_prd_info>>';

			TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>Inserting into bronze.crm_prd_info>>';

			BULK INSERT bronze.crm_prd_info

			from 'C:\Users\PC\Desktop\sql-ultimate-course\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
PRINT '>>load time duration is ' + CAST(DATEDIFF(second, @starttime,@endtime) AS NVARCHAR) + ' seconds'
PRINT '>>-------------'

SET @starttime =GETDATE();
		PRINT '>>Truncating table bronze.crm_sales_details>>';

			TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>>Inserting into bronze.crm_sales_details>>';

			BULK INSERT bronze.crm_sales_details

			from 'C:\Users\PC\Desktop\sql-ultimate-course\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

PRINT '>>load time duration is ' + CAST(DATEDIFF(second, @starttime,@endtime) AS NVARCHAR) + ' seconds'
PRINT '>>-------------'

		PRINT '---------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '---------------------------------------------';
	
SET @starttime =GETDATE();
		PRINT '>>Truncating table bronze.erp_loc_a101>>';
			TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>Inserting into bronze.erp_loc_a101>>';
			BULK INSERT bronze.erp_loc_a101

			from 'C:\Users\PC\Desktop\sql-ultimate-course\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
			with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
 

PRINT '>>load time duration is ' + CAST(DATEDIFF(second, @starttime,@endtime) AS NVARCHAR) + ' seconds'
PRINT '>>-------------'

SET @starttime =GETDATE();
		 PRINT '>>Truncating table bronze.erp_cust_az12>>';
			 TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>Inserting into bronze.erp_cust_az12>>';
			BULK INSERT bronze.erp_cust_az12

			from 'C:\Users\PC\Desktop\sql-ultimate-course\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
			with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
PRINT '>>load time duration is ' + CAST(DATEDIFF(second, @starttime,@endtime) AS NVARCHAR) + ' seconds'
PRINT '>>-------------'

SET @starttime =GETDATE();

		PRINT '>>Truncating table bronze.erp_px_cat_g1v2>>';

			TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>Inserting into bronze.erp_px_cat_g1v2>>';
			BULK INSERT bronze.erp_px_cat_g1v2

			from 'C:\Users\PC\Desktop\sql-ultimate-course\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
			with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
PRINT '>>load time duration is ' + CAST(DATEDIFF(second, @starttime,@endtime) AS NVARCHAR) + ' seconds'
PRINT '>>-------------'

PRINT '=============================================';
PRINT 'loading bronze layer is completed';
PRINT '=============================================';

SET @batch_end_time = GETDATE();

PRINT 'Total load time is ' + CAST(DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';

PRINT '=============================================';


	END TRY
BEGIN CATCH
	PRINT '=============================================';
	PRINT 'ERROR LOADING BRONZE LAYER';
	PRINT 'Error message'+ error_message();
	PRINT 'Error message'+ CAST (error_number() AS NVARCHAR);
	PRINT 'Error message'+ CAST (error_state() AS NVARCHAR);

	PRINT '=============================================';
END CATCH
END
