The MSSQL Source Connector is a powerful and efficient solution designed to facilitate seamless data integration between your Microsoft SQL Server (MSSQL) databases and Popsink. This connector helps you synchronize with Microsoft SQL Server in real-time, ensuring that your target systems remain updated with the latest information in real-time, driving business intelligence, analytics, and operational efficiency.

## Prerequisites

- You will need to enable Change Data Capture on the target. [See](https://debezium.io/documentation/reference/stable/connectors/sqlserver.html#_enabling_cdc_on_the_sql_server_database).

- A user with `SELECT` privileges. Members of the `db_owner` group or able to retrieve results from the stored procedure `sys.sp_cdc_help_change_data_capture` on the target work.

## Key Features

- Real-time Change Data Capture (CDC): the MSSQL Source Connector employs a CDC mechanism using the native Microsoft SQL Server logical decoding feature, capturing and streaming changes (inserts, updates, and deletes) as they occur in your database.

- Fault-tolerant and Scalable: The MSSQL Source Connector is built with fault tolerance and scalability in mind. It is capable of resuming data replication from the last known offset in case of failures, ensuring data consistency and minimal downtime.

- Initial Load: The connector automatically performs an initial full table load.

- Advanced Filtering: The MSSQL Source Connector provides a range of filtering options, including table and schema filters, allowing you to selectively replicate specific tables and schemas based on your needs.

## Security

The connector supports SSL/TLS encryption for secure communication between the connector and your Microsoft SQL Server database.
