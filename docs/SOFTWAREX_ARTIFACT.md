# SoftwareX Artifact

TOPIC Connector is the bounded software artifact released from the broader EITEL connector engineering work.

## Artifact Boundary

Core artifact:

- EDC runtime deployment artifacts;
- management UI;
- local-assets service;
- download-sink service;
- PostgreSQL persistence profile;
- Nginx gateway profile;
- Docker Compose reproduction stack.

Institutional profiles:

- UC3M production-like deployment;
- Fuenlabrada production-like deployment.

Experimental extensions:

- STAR connector profiles;
- dual connector proof-of-concept;
- LAN-oriented STAR proof-of-concept;
- CAAS-oriented generation experiments.

## Recommended Review Path

Reviewers should use:

```bash
cp .env.example .env
docker compose --env-file .env -f docker-compose.yaml up -d --build
./scripts/validate_stack.sh
./scripts/validate_local_asset_upload.sh
./scripts/validate_download_capture.sh
```

Production-like profiles are included for traceability and deployment engineering context, but they are not required for the SoftwareX reproduction check.
