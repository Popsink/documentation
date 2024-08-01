# MSSQL Source
The MSSQL Source Connector is a powerful and efficient solution designed to facilitate seamless data integration between your Microsoft SQL Server (MSSQL) databases and Popsink. This connector helps you synchronize with Microsoft SQL Server in real-time, ensuring that your target systems remain updated with the latest information in real-time, driving business intelligence, analytics, and operational efficiency.

## Table of Contents

1. [Key Features](#key-features)
2. [Security](#security)
3. [Prerequisites](#prerequisites)
4. [Creating a Dedicated Role](#creating-a-dedicated-role)
5. [Enabling CDC](#enabling-cdc)
5. [Housekeeping Scripts](#housekeeping-scripts)

## Key Features

- **Real-time Change Data Capture (CDC):** the MSSQL Source Connector employs a CDC mechanism using the native Microsoft SQL Server logical decoding feature, capturing and streaming changes (inserts, updates, and deletes) as they occur in your database.
- **Fault-tolerant and Scalable:** The MSSQL Source Connector is built with fault tolerance and scalability in mind. It is capable of resuming data replication from the last known offset in case of failures, ensuring data consistency and minimal downtime.
- **Initial Load:** The connector automatically performs an initial full table load.
- **Advanced Filtering:** The MSSQL Source Connector provides a range of filtering options, including table and schema filters, allowing you to selectively replicate specific tables and schemas based on your needs.

## Security

The connector supports SSL/TLS encryption for secure communication between the connector and your Microsoft SQL Server database.

## Prerequisites

- You will need to have Change Data Capture enabled on the tables you want to ingest. [See Enabling CDC](#enabling-cdc)
- You will need a user with the necessary permissions. [See Creating a Dedicated Role](#creating-a-dedicated-role)

### Relevant Roles
- **sysadmin:** role required for enabling CDC at the database level.
- **db_owner:** role required for enabling CDC at the table level.

## Creating a Dedicated Role

This step creates a dedicated replication ROLE, assigns it to your USER and grants it the necessary permissions to work with 

### Steps
1. **Create the Replication Role:**
    ```sql
    USE [{{your_database}}];
    GO
    CREATE ROLE cdc_role;
    GO
    ```
2. **Assign the Replication Role to a User:**
    ```sql
    USE [{{your_database}}];
    GO
    EXEC sp_addrolemember 'cdc_role', '{{your_user}}';
    GO
    ```
3. **Grant CDC Permissions:**
    ```sql
    USE [{{your_database}}];
    GO
    GRANT EXECUTE ON SCHEMA::cdc TO cdc_role;
    GO
    ```
4. **Grant Permissions to Check Version, Encryption, and Track Schema:**
    ```sql
    USE master;
    GO
    GRANT VIEW SERVER STATE TO cdc_role;
    GO

    USE {{your_database}};
    GO
    GRANT SELECT ON OBJECT::INFORMATION_SCHEMA.TABLES TO cdc_role;
    GO
    ```

## Enabling CDC

To enable CDC for your data, you need to do two things: 1) Enable CDC at the Database level, and 2) Enable CDC at the Table level. 

### For Databases
1. **Enable CDC on a Database:**
    ```sql
    USE [{{your_database}}];
    GO
    EXEC sys.sp_cdc_enable_db;
    GO
    ```

2. **Enable CDC on Multiple Databases:**
    ```sql
    DECLARE @databases CURSOR;
    SET @databases = CURSOR FOR
    SELECT name FROM sys.databases WHERE name IN ({{your_database_list}});

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

### For Tables
1. **Enable CDC on a Table:**
    ```sql
    USE [{{your_database}}];
    GO
    EXEC sys.sp_cdc_enable_table
        @source_schema = N'dbo',
        @source_name   = N'{{your_table}}',
        @role_name     = N'cdc_role', -- use @role_name = NULL if you haven't set up a role
        @supports_net_changes = 1;
    GO
    ```

2. **Enable CDC on multiple Tables:**
    ```sql
    DECLARE @tables CURSOR;
    SET @tables = CURSOR FOR
    SELECT schema_name(t.schema_id) as schema_name, t.name as table_name
    FROM sys.tables t
    WHERE t.name IN ({{your_table_list}});

    OPEN @tables;

    DECLARE @schemaName NVARCHAR(50);
    DECLARE @tableName NVARCHAR(50);

    FETCH NEXT FROM @tables INTO @schemaName, @tableName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('USE {{your_database}}; EXEC sys.sp_cdc_enable_table @source_schema = ''' + @schemaName + ''', @source_name = ''' + @tableName + ''', @role_name = ''cdc_user'' + @supports_net_changes = 1;');
        FETCH NEXT FROM @tables INTO @schemaName, @tableName;
    END;

    CLOSE @tables;
    DEALLOCATE @tables;
    ```

## Housekeeping Scripts

Here are a few useful scripts that can help you manage the CDC lifecycle.

### Purging Logs
Enabling Logs can take up space on your database so it's best practice to purge them regularly. There is a tradeoff between the log retention and the operational resilience of your replication pipeline. A longer retention means you will need more time to recover from outages before having to resync. Shorter retention takes up less space but gives you less time to recover.
1. **Purge CDC Logs:**
    ```sql
    -- Set the database and the retention period
    USE YourDatabaseName;
    GO

    DECLARE @retentionDays INT = 7; -- Set the retention period in days

    -- Convert retention days to a cutoff LSN
    DECLARE @retentionDateTime DATETIME = DATEADD(DAY, -@retentionDays, GETDATE());
    DECLARE @cutoffLSN BINARY(10);

    -- Retrieve the minimum LSN based on the retention date
    SELECT @cutoffLSN = sys.fn_cdc_map_time_to_lsn('smallest greater than or equal', @retentionDateTime);

    -- Check if the cutoff LSN is valid
    IF @cutoffLSN IS NOT NULL
    BEGIN
        DECLARE @capture_instance NVARCHAR(200);
        DECLARE @sql NVARCHAR(MAX);

        -- Cursor to go through each capture instance
        DECLARE instance_cursor CURSOR FOR
        SELECT capture_instance
        FROM cdc.change_tables;

        OPEN instance_cursor;

        FETCH NEXT FROM instance_cursor INTO @capture_instance;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Generate the cleanup command for each capture instance
            SET @sql = N'EXEC sys.sp_cdc_cleanup_change_table @capture_instance = ''' + @capture_instance + ''', @low_water_mark = ''' + CONVERT(NVARCHAR(100), @cutoffLSN, 1) + ''';';
        
            -- Execute the cleanup command
            EXEC sp_executesql @sql;

            FETCH NEXT FROM instance_cursor INTO @capture_instance;
        END;

        CLOSE instance_cursor;
        DEALLOCATE instance_cursor;

        PRINT 'CDC logs purged successfully up to ' + CONVERT(NVARCHAR(30), @retentionDateTime, 121);
    END
    ELSE
    BEGIN
        PRINT 'No valid LSN found for the specified retention period.';
    END
    GO
    ```

### Check if CDC is Enabled
1. **Check if it is Enabled on a Database:**
    ```sql
    USE master
    GO
    select name, is_cdc_enabled
    from sys.databases
    where name = '{{your_database}}'
    GO
    ```
    0 means CDC is not enabled, 1 means it is.
   
3. **Check if it is Enabled on a Table:**
    ```sql
    USE [{{your_database}}];
    GO
    select name,type,type_desc,is_tracked_by_cdc
    from sys.tables
    where name = ‘<table_name>’
    GO
    ```
   0 means CDC is not enabled, 1 means it is.

### Disable CDC
1. **Disable CDC on a Database:**
    ```sql
    USE [{{your_database}}];
    GO
    EXEC sys.sp_cdc_disable_db;
    GO
    ```
2. **Disable CDC on a Table:**
    ```sql
    USE [{{your_database}}];
    GO
    EXEC sys.sp_cdc_disable_table
        @source_schema = N'dbo',
        @source_name   = N'{{your_table}}',
        @capture_instance = N'dbo_{{your_table}}';
    GO
    ```

