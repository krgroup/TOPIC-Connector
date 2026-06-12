# Architecture

TOPIC Connector packages operational services around an Eclipse EDC connector runtime.

| Component | Technology | Input | Output |
| --- | --- | --- | --- |
| EDC runtime | Java / Eclipse EDC | Asset, policy, contract, negotiation, transfer requests | Connector state, agreements, transfer processes |
| Management UI | Static HTML/CSS/JS served by Nginx | Operator actions | Management API calls and user-facing status |
| local-assets | Python / FastAPI | File uploads and metadata | Stored file and retrievable source URL |
| download-sink | Python / FastAPI | Transfer payloads | Stored payload and traceable transfer record |
| PostgreSQL | PostgreSQL | Runtime persistence data | Durable connector state |
| Gateway | Nginx | External HTTP requests | Routed UI, management, DSP, local-assets, and download-sink traffic |

The local reproduction stack is intentionally compact. Production-like profiles instantiate the same pattern with institution-specific names, routing prefixes, ArcGIS settings, and persistence volumes.
