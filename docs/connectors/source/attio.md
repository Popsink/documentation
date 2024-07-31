# Attio Source

The Attio CRM Connector enables seamless data integration between your Attio CRM system and Popsink. This connector allows you to synchronize data from Attio in real-time, ensuring that your target systems are consistently updated with the latest information, enhancing business intelligence, analytics, and operational efficiency.

## Prerequisites
- Attio Account with Connection Privileges: Ensure you have an active Attio account with the necessary permissions to access and replicate data.

## Connecting Attio

In the source selection menu, select the Attio connector and click the "Connect" button.

![Screenshot 2024-07-31 205255](https://github.com/user-attachments/assets/64d88815-d2a4-4068-9863-905d17577b80)

A new window will open, prompting you to log in to your Attio account.
After logging in, grant the necessary permissions to allow Popsink to access your Attio data.

![Screenshot 2024-07-31 205319](https://github.com/user-attachments/assets/9845f0ee-9718-493b-a330-1eaad30659bd)

Once authenticated, you will be able to give your connector a name and select the Attio objects you wish to track.
In the "Table selection", you will be presented with a list of available objects in your Attio CRM.
Select the objects you wish to replicate to Popsink.
Once selected, click "Create connector"

![Screenshot 2024-07-31 205346](https://github.com/user-attachments/assets/95cbebcb-7092-40dd-9b74-adf9a98c4bce)

Your connector is ready! You can now use the "Subscribe to all" button to sync all objects from the connector with the destination of your choice.

![image](https://github.com/user-attachments/assets/3e72aa1a-d8a9-47e6-a35b-2015d4970f64)

## Key Features
- Real-time Data Synchronization: The Attio CRM Connector ensures real-time data synchronization, capturing changes as they happen in your Attio CRM and reflecting them in your target systems.

- Customizable Object Selection: You can choose specific objects from Attio to replicate, allowing you to tailor the data integration to your business needs.

- Schema Evolution and Compatibility: The connector automatically detects changes in the Attio objects schema and adjusts the data replication process accordingly, ensuring seamless data integration even as your CRM data structure evolves.

- Fault-tolerant and Scalable: Built with fault tolerance and scalability in mind, the Attio CRM Connector can resume data replication from the last known state in case of disruptions, ensuring data consistency and minimal downtime.

- Initial Data Load: The connector performs an initial full data load of the selected objects from Attio, setting up a comprehensive foundation for ongoing synchronization.

## Security
- OAuth 2.0 Authentication: The connector uses OAuth 2.0 for secure and reliable authentication, ensuring your Attio credentials are protected.

## Conclusion
The Attio CRM Connector is a robust solution for integrating your Attio data with Popsink, offering real-time synchronization, scalability, and security. With customizable object selection and advanced filtering options, it adapts to your specific data integration needs, driving enhanced business intelligence and operational efficiency.
