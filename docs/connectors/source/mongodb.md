# Mongodb Source

The MongoDB Source Connector is a powerful and efficient solution designed to facilitate seamless data integration between your MongoDB databases and Popsink. This connector helps you synchronize with MongoDB in real-time, ensuring that your target systems remain updated with the latest information in real-time, driving business intelligence, analytics, and operational efficiency.

## Prerequisites

- You may need to whitelist Popsink’s IP address.

- A `Replica Set` name: a replication set is a group of MongoDB instances sharing the same data and is defined in `replication.replSetName` for each instance in their respective configuration files ([see here](https://www.mongodb.com/docs/manual/replication/#replication-in-mongodb)).

- A user with:

  - `read` privileges on the `oplog` database.

  - `read` privileges on the `config` database.

  - `listDatabases` privileges.

  - Cluster-wide `find` and `changeStream` privileges.

## Key Features

- Real-time Change Data Capture (CDC): The MongoDB Source Connector employs a CDC mechanism using the native MongoDB logical decoding feature, capturing and streaming changes (inserts, updates, and deletes) as they occur in your database.

- Fault-tolerant and Scalable: The MongoDB Source Connector is built with fault tolerance and scalability in mind. It is capable of resuming data replication from the last known offset in case of failures, ensuring data consistency and minimal downtime.

- Initial Load: The connector automatically performs an initial full table load.

- Advanced Filtering: The MongoDB Source Connector provides a range of filtering options, including table and schema filters, allowing you to selectively replicate specific tables and schemas based on your needs.

## Security
 The connector supports SSL/TLS encryption for secure communication between the connector and your MongoDB database.
