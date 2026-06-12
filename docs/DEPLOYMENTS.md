# Deployment Profiles

## Supported Reproduction Profile

| File | Purpose |
| --- | --- |
| `docker-compose.yaml` | Local TOPIC Connector reproduction stack for SoftwareX review and smoke testing |

## Optional Supported Examples

| File | Purpose |
| --- | --- |
| `connectors/normal/docker-compose.yaml` | Standalone non-ArcGIS connector profile |

## Institutional Profiles

| File | Purpose |
| --- | --- |
| `docker-compose.production.yaml` | UC3M production-like deployment |
| `docker-compose.fuenlabrada.production.yaml` | Fuenlabrada production-like deployment |

These profiles preserve real deployment engineering patterns but are not the recommended first path for external reviewers.

## Experimental Profiles

| Path | Purpose |
| --- | --- |
| `connectors/star` | ArcGIS/trust-oriented experimental profile |
| `connectors/dual` | Local two-profile proof-of-concept |
| `connectors/star-pair` | Two STAR connector proof-of-concept |
| `connectors/star-lan` | LAN-oriented STAR proof-of-concept |
| `caas` | Connector-as-a-Service experiments and auxiliary services |

## Deprecated Profiles

| File | Status |
| --- | --- |
| `docker-compose-backup.yaml` | Legacy backup profile retained for traceability |
