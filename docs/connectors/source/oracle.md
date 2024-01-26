# Oracle Source

The Oracle Source Connector is an advanced tool designed to synchronize Oracle databases with Popsink efficiently and in real-time. It enables the real-time transfer of data, ensuring that the latest database changes are mirrored to the target systems. This capability is crucial for maintaining up-to-date business intelligence, enabling real-time analytics, and enhancing operational workflows.

## **Prerequisites**

Before deploying the Oracle Source Connector, certain prerequisites must be met to ensure a smooth integration process:

1. **Whitelisting Popsink's IP Address**: Ensure that Popsink's IP address **`13.37.99.137`** is whitelisted to allow uninterrupted communication between Oracle databases and Popsink.
2. **Database Log Mode Configuration**: The Oracle database Archive Mode should be set to ArchiveLog.
3. **Supplemental Logging**: Supplemental Logs should be enable on the source you wish to replicate. This can me done at Database or Table Level  :
    - At Database Level
    
    ```sql
    ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
    ```
    
    - At Table Level
    
    ```sql
    ALTER TABLE **{db.name}** ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;
    ```
    
    > Note: If using AWS RDS, additional steps may be required. Please consult the relevant AWS RDS documentation and do feel free to reach out for help.
    > 

## **Required Permissions**

Although you *could* use a **`superuser`**, we do recommend setting up dedicated users for security reasons. The user account that the Oracle Source Connector utilizes must have sufficient privileges. The following SQL statements outline the necessary permissions:

```sql
GRANT CREATE SESSION TO {username} CONTAINER=ALL;
GRANT SET CONTAINER TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$DATABASE to {username} CONTAINER=ALL;
GRANT FLASHBACK ANY TABLE TO {username} CONTAINER=ALL;
GRANT SELECT ANY TABLE TO {username} CONTAINER=ALL;
GRANT SELECT_CATALOG_ROLE TO {username} CONTAINER=ALL;
GRANT EXECUTE_CATALOG_ROLE TO {username} CONTAINER=ALL;
GRANT SELECT ANY TRANSACTION TO {username} CONTAINER=ALL;
GRANT LOGMINING TO {username} CONTAINER=ALL;
GRANT CREATE TABLE TO {username} CONTAINER=ALL;
GRANT LOCK ANY TABLE TO {username} CONTAINER=ALL;
GRANT CREATE SEQUENCE TO {username} CONTAINER=ALL;
GRANT EXECUTE ON DBMS_LOGMNR TO {username} CONTAINER=ALL;
GRANT EXECUTE ON DBMS_LOGMNR_D TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$LOG TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$LOG_HISTORY TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$LOGMNR_LOGS TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$LOGMNR_CONTENTS TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$LOGMNR_PARAMETERS TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$LOGFILE TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$ARCHIVED_LOG TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$ARCHIVE_DEST_STATUS TO {username} CONTAINER=ALL;
GRANT SELECT ON V_$TRANSACTION TO {username} CONTAINER=ALL;
```

Replace **`{username}`** with the actual username being used for the connection.

## Steps

Go to: **[Sources](https://app.popsink.com/sources) -**> [**Create New**](https://app.popsink.com/sources/add) then select the **Oracle** connector and **Continue**

In the *Credentials* sections fill in the required information

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/0adb1a06-b847-49c3-875f-e01fc0d1f6e5/d1756040-acaf-48a6-8c6f-df3b3579ec45/Untitled.png)

### **`host`**

- **Description**: The hostname or IP address of the Oracle database server.
- **Type**: **`string`**
- **Example**: **`oracle-db-server.example.com`**

### **`port`**

- **Description**: The port number on which the Oracle database server is listening.
- **Type**: **`integer`**
- **Default**: **`1521`** (default port for Oracle database)
- **Example**: **`1521`**

### **`user`**

- **Description**: The username used to connect to the Oracle database.
- **Type**: **`string`**
- **Example**: **`popsink_user`**

### **`password`**

- **Description**: The password associated with the specified user for authentication.
- **Type**: **`string`**
- **Example**: **`p@ssw0rd123`**

### **`database`**

- **Description**: The specific Oracle database (also referred to as a service name) to connect to.
- **Type**: **`string`**
- **Example**: **`ORCL`**

### **`server name`**

- **Description**: A logical name that identifies the Oracle server instance in Popsink, which can be useful for distinguishing between multiple sources.
- **Type**: **`string`**
- **Example**: **`oracle_source_01`**

### **`server id`**

- **Description**: A unique numeric identifier for the server instance. This is used by the connector for identifying itself to the database, which is particularly important for databases with multiple replicas.
- **Type**: **`integer`**
- **Constraints**: Must be a positive integer and unique across all Oracle Source Connectors.
- **Example**: **`5501`**

You can use **Check Credentials** at any moment to verify the validity of your inputs.

Once the validity check has passed, the next step is the standard *Informations* page where you may give the connector a name and select which of your teams should own this connector. 

Create the connector and you are now done. The connector may take a few minutes to synchronize with the source database.

## **Conclusion**

The Oracle Source Connector is an essential component for creating a reliable data pipeline between Oracle databases and Popsink. By following the guidelines provided in this document, you can ensure a successful setup and enjoy a robust, real-time data integration experience.