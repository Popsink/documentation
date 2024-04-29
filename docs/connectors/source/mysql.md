# Mysql Source

The MySQL Source Connector is a powerful and efficient solution designed to facilitate seamless data integration between your MySQL databases and Popsink. This connector helps you synchronize with MySQL in real-time, ensuring that your target systems remain updated with the latest information in real-time, driving business intelligence, analytics, and operational efficiency.

## Prerequisites

- You may need to whitelist Popsink’s IP address.

- Binlogs enabled in FULL. [See](https://debezium.io/documentation/reference/stable/connectors/mysql.html#enable-mysql-binlog).

- A user with the following privileges on the target source(s):

```sql
SELECT
 RELOAD
 SHOW DATABASES
 REPLICATION SLAVE
 REPLICATION CLIENT
```

if you want to connect with a ssh tunnel. Create the use with :

```sql
CREATE USER 'user'@'%' IDENTIFIED BY 'password';
```

## Key Features

- Real-time Change Data Capture (CDC): the MySQL Source Connector employs a CDC mechanism using the native MySQL Server logical decoding feature, capturing and streaming changes (inserts, updates, and deletes) as they occur in your database.

- Fault-tolerant and Scalable: The MySQL Source Connector is built with fault tolerance and scalability in mind. It is capable of resuming data replication from the last known offset in case of failures, ensuring data consistency and minimal downtime.

- Initial Load: The connector automatically performs an initial full table load.

- Advanced Filtering: The MySQL Source Connector provides a range of filtering options, including table and schema filters, allowing you to selectively replicate specific tables and schemas based on your needs.

## Security
 The connector supports SSL/TLS encryption for secure communication between the connector and your MySQL database.
