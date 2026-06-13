#!/usr/bin/env sh
set -eu

GATEWAY_URL="${GATEWAY_URL:-http://localhost:12000}"
COMPOSE_FILE="${COMPOSE_FILE:-docker-compose.yaml}"
ENV_FILE="${ENV_FILE:-.env}"

ok() {
  printf '[OK] %s\n' "$1"
}

fail() {
  printf '[FAIL] %s\n' "$1" >&2
  exit 1
}

retry() {
  label="$1"
  shift
  attempts="${RETRY_ATTEMPTS:-30}"
  delay="${RETRY_DELAY_SECONDS:-2}"
  i=1
  while [ "$i" -le "$attempts" ]; do
    if "$@"; then
      return 0
    fi
    sleep "$delay"
    i=$((i + 1))
  done
  fail "$label"
}

command -v docker >/dev/null 2>&1 || fail "docker is not available"
command -v curl >/dev/null 2>&1 || fail "curl is not available"

retry "gateway health endpoint is not reachable at $GATEWAY_URL/health" \
  curl -fsS "$GATEWAY_URL/health" >/dev/null
ok "Gateway reachable"

docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" ps >/dev/null || fail "docker compose stack is not available"
ok "Docker Compose stack visible"

retry "EDC runtime health endpoint is not reachable" \
  docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" exec -T conectoruc3m curl -fsS http://localhost:11000/api/check/health >/dev/null
ok "EDC runtime healthy"

retry "local-assets config endpoint is not reachable" \
  docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" exec -T conectoruc3m-local-assets \
  python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8081/v1/config', timeout=5).read()" >/dev/null
ok "local-assets reachable"
