# Snowflake Target
The Snowflake Target Connector is a robust tool designed to facilitate the seamless integration of Change Data Capture (CDC) updates into Snowflake data warehouses. Leveraging Snowpipe streaming functionality, this connector efficiently streams CDC updates into Snowflake, where they are written as inserts. Subsequently, a materialized view is employed to construct a copy of the source table, ensuring real-time data replication.

### Key Features

- CDC Streaming: Utilizes Snowpipe streaming to capture real-time changes from the source system.
- Insert Operation: Writes CDC updates as inserts into the target Snowflake database, preserving data integrity.
- Materialized View: Constructs a materialized view to mirror the source table, enabling easy access to replicated data.
- Time Travel Support: Retains historical data for time travel queries, facilitating data analysis and auditing.
- Private Authentication: Relies on Snowflake's private authentication mechanism for secure data transmission.

### Getting Started

To begin using the Snowflake Target Connector, follow these steps:

1. Prerequisites:
- A Snowflake account where you whish to sync your data
- A key pair (no pass phrase) for authentication with Snowflake
```bash
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.p8 -nocrypt

openssl rsa -in rsa_key.p8 -pubout -out rsa_key.pub
```

- In snowflake update user with the public key.

```sql
ALTER USER {user} SET RSA_PUBLIC_KEY='{public_key}';
```

- Copy the private key without the header and footer.
```
-----BEGIN PRIVATE KEY-----
-----END PRIVATE KEY-----
```
2. Configuration:
- In the Target section, select the Snowflake connector
- Fill in the required configuration, including the Snowflake key

### Conclusion

The Snowflake Target Connector offers a reliable and efficient solution for streaming CDC updates into Snowflake data warehouses. By leveraging Snowpipe streaming and materialized views, it enables seamless replication of real-time data while preserving historical information for analysis and auditing purposes. With built-in support for Snowflake's private authentication mechanism, it ensures secure and reliable data transmission, making it an indispensable tool for data integration workflows.