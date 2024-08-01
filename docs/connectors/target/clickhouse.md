# ClickHouse Target
Welcome to the ClickHouse Target Connector documentation. This guide is designed to help you effectively integrate and utilize ClickHouse as a data sink for your CDC (Change Data Capture) data pipelines. The ClickHouse Target Connector allows you to seamlessly transfer data from your tools, applications and services to a ClickHouse database, leveraging its high performance for analytics and large-scale data storage.

### Overview

ClickHouse is an open-source columnar database management system that is optimized for OLAP (Online Analytical Processing) scenarios. It is designed to process billions of rows and gigabytes of data per second with low latency. Using the ClickHouse Target Connector, you can push data from various sources into your ClickHouse instance, making it available for analysis and reporting.

### Features

- **High Performance**: Utilizes ClickHouse's capabilities for handling large volumes of data with high insertion speeds.
- **Real-time Ingestion**: Popsink sinks data in real-time to your Clickhouse tables.
- **Data Consistency**: Includes features for handling duplicates and ensuring data consistency.
- **Incremental Writes**: Popsink leverages Change Data Capture and ClickHouse’s ReplacingMergeTree to write incremental updates and deletes to your tables. You can read more about forcing deduplication in the [FINAL modifier documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/from#final-modifier).

### Prerequisites

Before setting up the ClickHouse Target Connector, ensure you have the following:

- A running ClickHouse server accessible from the service.
- A user with appropriate credentials and permissions to access and write to the ClickHouse database. Should you wish to create a new user, here is how you could do so:

```sql
CREATE ROLE POPSINK_ROLE;
GRANT SELECT, CREATE, SHOW, INSERT  ON <my_database>.* TO POPSINK_ROLE;

CREATE USER <popsink_user> IDENTIFIED WITH sha256_password BY '<my_password>'
GRANT POPSINK_ROLE TO <popsink_user>;
```

### Configuration

To configure the ClickHouse Target Connector, follow these steps:

- **Username**: if you followed the Prerequisites, this will be ```<popsink_user>```. Otherwise use the username you wish to use.
- **Password**: if you followed the Prerequisites, this will be ```<my_password>```. Otherwise use the corresponding password for the username in the previous step.
- **Host**: You can find the Host in the “Connect” option of your Clickhouse Console, it should look like this: ```6dw0f8sj4.us-east-1.aws.clickhouse.cloud```
- **Port**: For Clickhouse Cloud this is generally ```8443```
- **Database Name**: if you followed the Prerequisites, this will be ```<my_database>```. Otherwise specify the name of the database you wish to write in.


