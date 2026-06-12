# Contributing

Contributions are welcome through GitHub issues and pull requests.

## Development Guidelines

- Keep the SoftwareX reproduction path in `docker-compose.yaml` working.
- Do not commit real credentials, generated databases, local uploaded assets, or private Gaia-X material.
- Prefer small pull requests with a clear motivation and validation steps.
- For frontend changes, run syntax checks where possible:

```bash
node --check caas/edc-ui/public/assets/ui/02f-star.js
node --check caas/edc-ui/public/assets/ui/02g-download.js
node --check caas/edc-ui/public/assets/ui/02h-arcgis.js
node --check caas/edc-ui/public/assets/ui/02i-management.js
```

## Reporting Problems

Please include:

- repository commit or release tag;
- deployment profile used;
- Docker Compose command;
- relevant logs;
- expected and observed behavior.
