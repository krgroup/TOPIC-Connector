# TOPIC Connector v1.0.9

CI readiness release for the TOPIC Connector SoftwareX artifact.

## Highlights

- Adds health checks for the local-assets and download-sink services in the primary Docker Compose stack.
- Splits functional smoke checks into separate GitHub Actions steps.
- Adds retry logic to smoke-test scripts to tolerate service startup timing in CI.
- Keeps the reviewed artifact version aligned across paper, README, CITATION metadata, changelog, and reproducibility guide.

## Review Path

```bash
git clone https://github.com/krgroup/TOPIC-Connector.git
cd TOPIC-Connector
git checkout v1.0.9
cp .env.example .env
docker compose --env-file .env -f docker-compose.yaml up -d --build
./scripts/validate_stack.sh
./scripts/validate_local_asset_upload.sh
./scripts/validate_download_capture.sh
```

## Notes

The primary SoftwareX review path is the local Docker Compose stack in `docker-compose.yaml`. Institutional and experimental profiles remain in the repository for traceability, but they are not required for the artifact smoke tests.
