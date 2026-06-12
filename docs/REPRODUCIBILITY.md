# Reproducibility Guide

This guide describes the recommended local reproduction path for TOPIC Connector.

## 1. Clone

```bash
git clone https://github.com/krgroup/TOPIC-Connector.git
cd TOPIC-Connector
git checkout v1.0.0
```

If the tag is not available in a local clone, use the `main` branch corresponding to the release.

## 2. Configure

```bash
cp .env.example .env
```

For PowerShell:

```powershell
Copy-Item .env.example .env
```

The local reproduction profile disables ArcGIS login by default and uses placeholder credentials suitable for a local test stack.

## 3. Start

```bash
docker compose --env-file .env -f docker-compose.yaml up -d --build
```

## 4. Validate

Run:

```bash
./scripts/validate_stack.sh
./scripts/validate_local_asset_upload.sh
./scripts/validate_download_capture.sh
```

Expected output contains `[OK]` lines for gateway reachability, service health, local upload, and download-capture record listing.

## 5. Stop

```bash
docker compose --env-file .env -f docker-compose.yaml down
```

Avoid `down -v` unless all local persistent state can be deleted.

## Notes

- The reproduction path is intentionally local and does not require ArcGIS Enterprise.
- Institutional profiles are documented separately and may require real DNS names, ArcGIS configuration, and production secrets.
- Some historical demo profiles expose credentials through browser-visible variables. Treat those profiles as local-only demonstrations.
