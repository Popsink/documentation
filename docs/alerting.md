# Popsink Alerting with Source and Target Connectors

Popsink provides native observability through a custom Source Connector that streams the runtime activity of other Popsink connectors. This allows you to monitor connector health, failures, retries, and throughput in real time.

Using Popsink pipelines, you can apply alerting rules to this activity stream and route critical events to external systems via Target Connectors (Slack, Database, Webhooks, etc.).

This creates a fully integrated alerting pipeline without requiring third-party monitoring systems.

## Architecture

1. Popsink Source Connector (Internal Activity Source)

    - Captures events about Popsink connector activity:
        - Connector lifecycle events (started, stopped, failed)
        - Task health (heartbeat, lag, retries, errors)
    - Exposes them as a continuous event stream.

2. Target Connectors

    - Forward alert events to external systems.

## Use Cases

- Detect if a connector crashes or stops unexpectedly.
- Trigger alerts when error rates exceed thresholds.