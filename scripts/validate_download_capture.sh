#!/usr/bin/env sh
set -eu

GATEWAY_URL="${GATEWAY_URL:-http://localhost:12000}"
if [ -z "${LOCAL_ASSETS_AUTH_TOKEN:-}" ] && [ -f .env ]; then
  LOCAL_ASSETS_AUTH_TOKEN="$(sed -n 's/^LOCAL_ASSETS_AUTH_TOKEN=//p' .env | tail -n 1)"
fi
TOKEN="${LOCAL_ASSETS_AUTH_TOKEN:-CHANGE_ME_LOCAL_ASSET_TOKEN}"

ok() {
  printf '[OK] %s\n' "$1"
}

fail() {
  printf '[FAIL] %s\n' "$1" >&2
  exit 1
}

command -v curl >/dev/null 2>&1 || fail "curl is not available"

payload='{"message":"TOPIC Connector validation payload"}'
contract_id="validation-contract"
asset_id="validation-asset"
transfer_id="validation-transfer"

curl -fsS \
  -H "x-api-key: $TOKEN" \
  -H "x-contract-id: $contract_id" \
  -H "x-asset-id: $asset_id" \
  -H "x-transfer-id: $transfer_id" \
  -H "content-type: application/json" \
  --data "$payload" \
  "$GATEWAY_URL/conectoruc3m/download-sink/ingest" >/dev/null \
  || fail "download-sink ingest failed"

records="$(curl -fsS -H "x-api-key: $TOKEN" "$GATEWAY_URL/conectoruc3m/download-sink/records")" \
  || fail "download-sink records endpoint failed"

printf '%s' "$records" | grep "$contract_id" >/dev/null \
  || fail "download-sink record was not listed"

ok "download-sink record listed"
