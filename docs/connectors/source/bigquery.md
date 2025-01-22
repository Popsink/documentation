# BigQuery Source
The BigQuery Source integration in PopSink allows you to seamlessly ingest data from a BigQuery database into PopSink pipelines. With this connector, you can extract structured data for processing, transformation, and further downstream operations.

## Prerequisites

The table should be configure with :
```sql
enable_change_history=TRUE
```

## Permissions

- bigquery.tables.getData