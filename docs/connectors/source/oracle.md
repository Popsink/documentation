# Oracle source

The Oracle Source Connector is a powerful and efficient solution designed to facilitate seamless data integration between your Oracle databases and Popsink. This connector helps you synchronize with Oracle in real-time, ensuring that your target systems remain updated with the latest information in real-time, driving business intelligence, analytics, and operational efficiency.

## Prerequisites

- You may need to whitelist Popsink’s IP address.

- If not done yet, set the database log mode to [Archive](https://debezium.io/documentation/reference/stable/connectors/oracle.html#_preparing_the_database).

- Enable supplemental logs for the sources you wish to capture using:

```sql
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
 ALTER TABLE {db.name} ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;
```

Please note that you can select wich columns to replicate.
If you are using AWS RDS please visit this [link](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.CommonDBATasks.Log.html)

A user with the following privileges:

```sql
GRANT CREATE SESSION TO {username} CONTAINER=ALL;
 GRANT SET CONTAINER TO {username} CONTAINER=ALL;
 GRANT SELECT ON V\_$DATABASE to {username} CONTAINER=ALL;
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
 GRANT SELECT ON V\_$LOG TO {username} CONTAINER=ALL;
 GRANT SELECT ON V\_$LOG_HISTORY TO {username} CONTAINER=ALL;
 GRANT SELECT ON V\_$LOGMNR_LOGS TO {username} CONTAINER=ALL;
 GRANT SELECT ON V\_$LOGMNR_CONTENTS TO {username} CONTAINER=ALL;
 GRANT SELECT ON V_$LOGMNR_PARAMETERS TO {username} CONTAINER=ALL;
 GRANT SELECT ON V_$LOGFILE TO {username} CONTAINER=ALL;
 GRANT SELECT ON V_$ARCHIVED_LOG TO {username} CONTAINER=ALL;
 GRANT SELECT ON V_$ARCHIVE_DEST_STATUS TO {username} CONTAINER=ALL;
 GRANT SELECT ON V_$TRANSACTION TO {username} CONTAINER=ALL;
```
