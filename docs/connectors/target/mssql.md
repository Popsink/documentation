# MSSQL Target
The SQL Server Target Connector enables you to stream data from Popsink directly into a SQL Server database. This connector is ideal for scenarios where you need to store and manage relational data in a SQL Server environment. It supports various data formats and allows for real-time updates to SQL Server tables. By configuring this connector, you can ensure that your SQL Server database is continuously synchronized with data from Popsink, facilitating data integration, reporting, and analysis. It's particularly valuable for applications that rely on structured data and require robust querying capabilities provided by SQL Server.

---

# 🗃️ SQL Server Target Connection Setup Guide

This guide provides step-by-step instructions to configure a **SQL Server** as a **target connection** in Popsink, allowing you to stream and load processed data into your Microsoft SQL Server instance.

---

## ✅ Prerequisites

Before configuring the target, ensure you have the following:

* A running Microsoft SQL Server instance (on-premise or cloud-hosted)
* A user account with `CREATE TABLE`, `INSERT` and `UPDATE` privileges on the target database
* Network access from Popsink to the SQL Server host (ensure firewall & security group rules allow inbound traffic)

---

## 🔌 Connection Parameters

When setting up the target in Popsink, you'll need to provide the following:

| Parameter         | Description                                                               |
| ----------------- | ------------------------------------------------------------------------- |
| **Host**          | The IP address or DNS name of your SQL Server (e.g., `sql.mycompany.com`) |
| **Port**          | The port number used by SQL Server (default: `1433`)                      |
| **Database**      | Name of the target database where data will be written                    |
| **Username**      | SQL Server login with appropriate privileges                              |
| **Password**      | Password for the specified username                                       |

---

## 🏗️ Setting Up the Connection in Popsink

1. **Navigate to Targets**
   In the Popsink dashboard, go to **Connections** > **Targets** > **Add New Target**.

2. **Choose SQL Server**
   Select **Microsoft SQL Server** from the list of target types.

3. **Enter Connection Details**
   Fill in the form using the connection parameters listed above.

4. **Test Connection**
   Click **Test Connection** to verify that Popsink can reach your SQL Server.

5. **Save**
   Once validated, click **Save**. You can now use this target in your pipelines.

---

## 🧩 Table & Schema Considerations

* Popsink supports **automatic table creation**.
* Source data models must have primary keys if **upserts** are enabled.

---

## 🔐 Security Notes

* Ensure the SQL Server user has **least privilege access** needed to insert and update data only in the required schema/tables.
* For cloud-hosted SQL Server (e.g., Azure SQL Database), ensure Popsink IPs are whitelisted.

---

## 🛠️ Troubleshooting

| Issue                  | Suggested Resolution                                             |
| ---------------------- | ---------------------------------------------------------------- |
| Cannot connect to host | Verify firewall rules, DNS resolution, and network reachability  |
| Login failed for user  | Confirm username/password and SQL Server authentication mode     |
