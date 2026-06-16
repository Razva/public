#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${APP_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
SERVICE_NAME="${NEXT_DEV_SERVICE:-}"
APP_URL="${APP_DEV_URL:-}"

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'HELP'
Usage:
  bash scripts/clear-dev-cache.sh
  NEXT_DEV_SERVICE=<service-name>.service APP_DEV_URL=<app-url> bash scripts/clear-dev-cache.sh

Clears local Next/Turbopack and TypeScript dev caches for the current app.

The script never uses elevated privileges and never kills arbitrary processes.
It only stops and restarts a user-level systemd service when NEXT_DEV_SERVICE
is explicitly provided and that service exists.

Environment:
  APP_ROOT          App root directory. Defaults to the parent of this script.
  NEXT_DEV_SERVICE User-level systemd service to stop/start, optional.
  APP_DEV_URL      URL used for readiness checks after restart, optional.
HELP
  exit 0
fi

cd "$ROOT_DIR"

service_exists() {
  [[ -n "$SERVICE_NAME" ]] && systemctl --user list-unit-files "$SERVICE_NAME" >/dev/null 2>&1
}

echo "Clearing Next dev caches in: $ROOT_DIR"

if service_exists; then
  echo "Stopping $SERVICE_NAME..."
  systemctl --user stop "$SERVICE_NAME" || true
elif [[ -n "$SERVICE_NAME" ]]; then
  echo "Configured service does not exist: $SERVICE_NAME"
fi

echo "Removing Next/Turbopack cache..."
rm -rf .next

echo "Removing TypeScript incremental cache..."
rm -f tsconfig.tsbuildinfo

echo "Cache cleared."

if service_exists; then
  echo "Starting $SERVICE_NAME..."
  systemctl --user start "$SERVICE_NAME"

  if [[ -n "$APP_URL" ]]; then
    echo "Waiting for Next to respond on $APP_URL..."
    for _attempt in {1..20}; do
      if curl -fsSI --max-time 2 "$APP_URL" >/dev/null; then
        echo "Next is online."
        systemctl --user --no-pager --lines=0 status "$SERVICE_NAME"
        exit 0
      fi

      sleep 1
    done

    echo "Next did not respond after 20 seconds. Recent logs:"
    journalctl --user -u "$SERVICE_NAME" --no-pager -n 40
    exit 1
  fi

  systemctl --user --no-pager --lines=0 status "$SERVICE_NAME"
  exit 0
fi

echo "No user service restarted. Start dev manually or set NEXT_DEV_SERVICE."
