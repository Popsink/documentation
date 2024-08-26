# BigQuery Target

The BigQuery Target Connector enables seamless integration with Google BigQuery, a fully-managed, serverless data warehouse that enables super-fast SQL queries using the processing power of Google's infrastructure. This connector allows you to stream data from Popsink directly into BigQuery tables, supporting both batch and real-time data ingestion. It automatically handles schema mapping, data type conversion, and can create or update tables as needed. The BigQuery connector is particularly useful for organizations looking to perform large-scale data analytics, run complex queries on massive datasets, or combine streaming data with historical data for comprehensive business intelligence. It enables data teams to leverage BigQuery's powerful analytics capabilities while maintaining low-latency data pipelines from various sources through Popsink.

## Permissions

- bigquery.tables.create
- bigquery.tables.delete
- bigquery.tables.updateData
- bigquery.tables.update
- bigquery.jobs.create
