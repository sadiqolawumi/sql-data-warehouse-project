USE master;
go

--Drop and recreate the 'Datawarehouse' database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name ='Datawarehouse')
BEGIN
  ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE Datawarehouse;
END;
GO

  --create the 'Datawarehouse' database 
create database Datawarehouse;
go
  
Use Datawarehouse;
go

create schema bronze;
go
create schema silver;
go
create schema gold;
go
