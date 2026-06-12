# Security Policy

## Supported Version

Security fixes target the latest released version of TOPIC Connector.

## Reporting A Vulnerability

Please report suspected vulnerabilities privately to the maintainers instead of opening a public issue. Include:

- affected version or commit;
- deployment profile;
- configuration pattern;
- reproduction steps;
- potential impact.

## Important Deployment Notes

- Do not expose privileged EDC Management API credentials to untrusted browser clients.
- Treat `NEXT_PUBLIC_*` credentials in demo profiles as local demonstration only.
- Use strong values for `EDC_API_AUTH_KEY`, `LOCAL_ASSETS_AUTH_TOKEN`, and database passwords.
- Never commit `.env`, `.env.production`, database dumps, local uploaded assets, or private Gaia-X credentials.
