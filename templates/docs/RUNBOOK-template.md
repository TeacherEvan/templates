# Runbook: <Service Name>

## Overview

One line on what this service does and who owns it.

## Prerequisites

- Access to: `<system>` (role: `operator`)
- Repo: `org/service`

## Common operations

### Deploy

```bash
# staging
./deploy.sh staging
```

### Rollback

```bash
./rollback.sh <previous-version>
```

## Health checks

- Liveness: `GET /health`
- Metrics: `GET /actuator/prometheus`

## Incident response

| Symptom | Likely cause | First action |
|---|---|---|
| 5xx spike | downstream timeout | check `GET /health` of dependency |
| High latency | DB connection pool exhausted | restart worker, then scale up |

## Escalation

Page the on-call: `#team-oncall` (Slack) or `oncall@example.com`.
