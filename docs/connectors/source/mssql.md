# MSSQL Source
The MSSQL Source Connector is a powerful and efficient solution designed to facilitate seamless data integration between your Microsoft SQL Server (MSSQL) databases and Popsink. This connector helps you synchronize with Microsoft SQL Server in real-time, ensuring that your target systems remain updated with the latest information in real-time, driving business intelligence, analytics, and operational efficiency.

## Table of Contents
1. [Permissions](#permissions)
2. [Creating and Assigning a Replication Role to a User](#creating-and-assigning-a-replication-role-to-a-user)
3. [Enabling CDC](#enabling-cdc)
   - [For One Database](#for-one-database)
   - [For One Table](#for-one-table)
   - [For Multiple Databases](#for-multiple-databases)
   - [For Multiple Tables](#for-multiple-tables)
4. [Disabling CDC](#disabling-cdc)
   - [For a Database](#for-a-database)
   - [For a Table](#for-a-table)
5. [Housekeeping Scripts](#housekeeping-scripts)
   - [Purging Logs](#purging-logs)

## Key Features

- Real-time Change Data Capture (CDC): the MSSQL Source Connector employs a CDC mechanism using the native Microsoft SQL Server logical decoding feature, capturing and streaming changes (inserts, updates, and deletes) as they occur in your database.

- Fault-tolerant and Scalable: The MSSQL Source Connector is built with fault tolerance and scalability in mind. It is capable of resuming data replication from the last known offset in case of failures, ensuring data consistency and minimal downtime.

- Initial Load: The connector automatically performs an initial full table load.

- Advanced Filtering: The MSSQL Source Connector provides a range of filtering options, including table and schema filters, allowing you to selectively replicate specific tables and schemas based on your needs.

## Security

The connector supports SSL/TLS encryption for secure communication between the connector and your Microsoft SQL Server database.



---

## Prerequisites

- You will need to enable Change Data Capture on the target. [See](https://debezium.io/documentation/reference/stable/connectors/sqlserver.html#_enabling_cdc_on_the_sql_server_database).

- A user with `SELECT` privileges. Members of the `db_owner` group or able to retrieve results from the stored procedure `sys.sp_cdc_help_change_data_capture` on the target work.


## Permissions
### Overview
To use Change Data Capture (CDC) in SQL Server, specific permissions are required. These permissions ensure that only authorized users can enable, disable, and manage CDC.

### Required Permissions
- **SysAdmin:** role required for enabling CDC at the database level.

Other relevant roles:
- **DbOwner Role:** role required for enabling CDC at the table level.
- **DbDataReader and DbDataWriter:** role required for querying and managing the change tables.
- **SQLAgentOperatorRole:** role required for managing SQL Server Agent jobs related to CDC.

## Creating and Assigning a Replication Role to a User

This step is optional as any DbOwner user will be able to access the replication logs on the tables for the databases they are an owner of.

USE master;
GO  
 
-- Grant VIEW SERVER STATE permission to access dm_exec_connections and  SERVERPROPERTY 
GRANT VIEW SERVER STATE TO {{your_username}}; 
GO 
 
-- Grant SELECT permission on INFORMATION_SCHEMA.TABLES 
GRANT SELECT ON OBJECT::INFORMATION_SCHEMA.TABLES TO {{your_username}}; 
GO  

### Steps
1. **Create the Replication Role:**
    ```sql
    USE [YourDatabase];
    GO
    CREATE ROLE cdc_user;
    GO
    ```
2. **Assign the Replication Role to a User:**
    ```sql
    USE [YourDatabase];
    GO
    EXEC sp_addrolemember 'cdc_user', '{{your_username}}';
    GO
    ```
3. **Grant Required Permissions:**
    ```sql
    USE [YOUR_DATABASE_HERE];
    GO
    GRANT EXECUTE ON SCHEMA::cdc TO cdc_user;
    GO
    ```

## Enabling CDC

### For One Database
1. **Enable CDC on the Database:**
    ```sql
    USE [YOUR_DATABASE_HERE];
    GO
    EXEC sys.sp_cdc_enable_db;
    GO
    ```

### For One Table
1. **Enable CDC on a Table:**
    ```sql
    USE [YOUR_DATABASE_HERE];
    GO
    EXEC sys.sp_cdc_enable_table
        @source_schema = N'dbo',
        @source_name   = N'YOUR_TABLE_HERE',
        @role_name     = N'cdc_user', -- use @role_name = NULL if you haven't set up a role
        @supports_net_changes = 1;
    GO
    ```

### For Multiple Databases
1. **Enable CDC on Each Database:**
    ```sql
    DECLARE @databases CURSOR;
    SET @databases = CURSOR FOR
    SELECT name FROM sys.databases WHERE name IN (YOUR_DATABASE_LIST_HERE);

    OPEN @databases;

    DECLARE @dbName NVARCHAR(50);

    FETCH NEXT FROM @databases INTO @dbName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('USE ' + @dbName + '; EXEC sys.sp_cdc_enable_db;');
        FETCH NEXT FROM @databases INTO @dbName;
    END;

    CLOSE @databases;
    DEALLOCATE @databases;
    ```

### For Multiple Tables
1. **Enable CDC on Each Table:**
    ```sql
    DECLARE @tables CURSOR;
    SET @tables = CURSOR FOR
    SELECT schema_name(t.schema_id) as schema_name, t.name as table_name
    FROM sys.tables t
    WHERE t.name IN ('Table1', 'Table2');

    OPEN @tables;

    DECLARE @schemaName NVARCHAR(50);
    DECLARE @tableName NVARCHAR(50);

    FETCH NEXT FROM @tables INTO @schemaName, @tableName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('USE YourDatabase; EXEC sys.sp_cdc_enable_table @source_schema = ''' + @schemaName + ''', @source_name = ''' + @tableName + ''', @role_name = ''cdc_user'' + @supports_net_changes = 1;');
        FETCH NEXT FROM @tables INTO @schemaName, @tableName;
    END;

    CLOSE @tables;
    DEALLOCATE @tables;
    ```

## Disabling CDC

### For a Database
1. **Disable CDC on the Database:**
    ```sql
    USE [YourDatabase];
    GO
    EXEC sys.sp_cdc_disable_db;
    GO
    ```

### For a Table
1. **Disable CDC on a Table:**
    ```sql
    USE [YourDatabase];
    GO
    EXEC sys.sp_cdc_disable_table
        @source_schema = N'dbo',
        @source_name   = N'YourTable',
        @capture_instance = N'dbo_YourTable';
    GO
    ```

## Housekeeping Scripts

### Purging Logs
1. **Purge CDC Logs:**
    ```sql
    USE [YourDatabase];
    GO
    EXEC sys.sp_cdc_cleanup_change_table
        @capture_instance = 'dbo_YourTable',
        @low_water_mark = '<LSN>';
    GO
    ```

Note: Replace `<LSN>` with the appropriate log sequence number up to which you want to retain the logs.

---

This documentation provides a structured guide to managing Change Data Capture (CDC) in SQL Server, covering essential tasks from enabling and disabling CDC to maintaining log files. Each section includes relevant SQL commands to facilitate implementation.
