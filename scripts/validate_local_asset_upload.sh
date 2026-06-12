#!/usr/bin/env sh
set -eu

GATEWAY_URL="${GATEWAY_URL:-http://localhost:12000}"
if [ -z "${LOCAL_ASSETS_AUTH_TOKEN:-}" ] && [ -f .env ]; then
  LOCAL_ASSETS_AUTH_TOKEN="$(sed -n 's/^LOCAL_ASSETS_AUTH_TOKEN=//p' .env | tail -n 1)"
fi
TOKEN="${LOCAL_ASSETS_AUTH_TOKEN:-CHANGE_ME_LOCAL_ASSET_TOKEN}"
FILE="${1:-examples/sample.geojson}"

ok() {
  printf '[OK] %s\n' "$1"
}

fail() {
  printf '[FAIL] %s\n' "$1" >&2
  exit 1
}

command -v curl >/dev/null 2>&1 || fail "curl is not available"
[ -f "$FILE" ] || fail "sample file not found: $FILE"

response="$(curl -fsS \
  -H "x-api-key: $TOKEN" \
  -F "file=@$FILE" \
  "$GATEWAY_URL/conectoruc3m/local-assets/upload")" \
  || fail "local asset upload failed"

printf '%s' "$response" | grep -E '"publicUrl"|"filename"' >/dev/null \
  || fail "upload response does not contain expected file metadata"

ok "local asset uploaded"
