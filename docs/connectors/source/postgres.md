The Postgres Source Connector is a powerful and efficient solution designed to facilitate seamless data integration between your PostgreSQL databases and Popsink. This connector helps you synchronize with PostgreSQL in real-time, ensuring that your target systems remain updated with the latest information in real-time, driving business intelligence, analytics, and operational efficiency.

## Prerequisites

- Your Postgres should be in `logical` mode (use `SHOW wal_level`). More info here.

- A user with `REPLICATION` rights on the tables you wish to connect to. One way to do this is (for others, check here):

```sql
CREATE ROLE replication_role REPLICATION;
GRANT replication_role TO <your_user>;
```

- Are you using PostgreSQL on Heroku? Here’s a great guide to [migrating](https://towardsdatascience.com/migrating-from-heroku-postgres-to-amazon-rds-2e738e7730e5).

- Each table should have is `REPLICA IDENTITY` set to `FULL`

```sql
ALTER TABLE mytable REPLICA IDENTITY FULL
```

- You have to create publications for your tables

```sql
CREATE PUBLICATION popsink FOR TABLE <your table list here>;
```

- The user should have the rights to list tables.

## Key Features

- Real-time Change Data Capture (CDC): The Postgres Source Connector employs a CDC mechanism using the native PostgreSQL logical decoding feature, capturing and streaming changes (inserts, updates, and deletes) as they occur in your database.

- Schema Evolution and Compatibility: This connector supports schema evolution, automatically detecting changes in the PostgreSQL database schema and adapting the data stream accordingly.

- Fault-tolerant and Scalable: The Postgres Source Connector is built with fault tolerance and scalability in mind. It is capable of resuming data replication from the last known offset in case of failures, ensuring data consistency and minimal downtime.

- Initial Load: The connector automatically performs an initial full table load.

- Advanced Filtering: The Postgres Source Connector provides a range of filtering options, including table and schema filters, allowing you to selectively replicate specific tables and schemas based on your needs.

## Security

The connector supports SSL/TLS encryption for secure communication between the connector and your PostgreSQL database.
