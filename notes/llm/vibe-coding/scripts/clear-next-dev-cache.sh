#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${APP_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
SERVICE_NAME="${NEXT_DEV_SERVICE:-}"
APP_URL="${APP_DEV_URL:-}"
CONFIRM_STOPPED=false
SERVICE_STOPPED=false

usage() {
  cat <<'HELP'
Usage:
  NEXT_DEV_SERVICE=<service>.service bash scripts/clear-next-dev-cache.sh
  bash scripts/clear-next-dev-cache.sh --confirm-stopped

Clears the complete disposable local Next.js build cache and TypeScript incremental state.

The script never uses elevated privileges or kills arbitrary processes. It either
stops and restarts an explicitly configured user-level systemd service, or requires
the caller to confirm that every process using this checkout is already stopped.

Options:
  --confirm-stopped  Confirm that no process is using this checkout.
  -h, --help         Show this help.

Environment:
  APP_ROOT          Application root. Defaults to the expected root when this
                    template is installed at scripts/clear-next-dev-cache.sh.
  NEXT_DEV_SERVICE  User-level systemd service to stop and restart, optional.
  APP_DEV_URL       URL used for readiness checks after restart, optional.
HELP
}

case "${1:-}" in
  "") ;;
  --confirm-stopped) CONFIRM_STOPPED=true ;;
  -h|--help) usage; exit 0 ;;
  *) usage >&2; exit 2 ;;
esac

ROOT_DIR="$(cd "$ROOT_DIR" && pwd -P)"

if [[ "$ROOT_DIR" == "/" || ! -f "$ROOT_DIR/package.json" ]]; then
  echo "Refusing to clear an invalid application root: $ROOT_DIR" >&2
  exit 1
fi

if ! grep -Eq '"next"[[:space:]]*:' "$ROOT_DIR/package.json"; then
  echo "Refusing to clear a project whose package.json does not declare Next.js: $ROOT_DIR" >&2
  exit 1
fi

service_exists() {
  [[ -n "$SERVICE_NAME" ]] && systemctl --user list-unit-files "$SERVICE_NAME" >/dev/null 2>&1
}

restart_after_failure() {
  if [[ "$SERVICE_STOPPED" == true ]]; then
    echo "Restarting $SERVICE_NAME after an interrupted cache clear..." >&2
    systemctl --user start "$SERVICE_NAME" || true
  fi
}

trap restart_after_failure EXIT

if [[ -n "$SERVICE_NAME" ]]; then
  if ! service_exists; then
    echo "Configured user service does not exist: $SERVICE_NAME" >&2
    exit 1
  fi

  echo "Stopping $SERVICE_NAME..."
  systemctl --user stop "$SERVICE_NAME"
  SERVICE_STOPPED=true
elif [[ "$CONFIRM_STOPPED" != true ]]; then
  echo "Refusing broad cache removal without a managed service or --confirm-stopped." >&2
  exit 1
fi

echo "Clearing Next.js and TypeScript caches in: $ROOT_DIR"
rm -rf -- "$ROOT_DIR/.next"
rm -f -- "$ROOT_DIR/tsconfig.tsbuildinfo"
echo "Cache cleared."

if [[ "$SERVICE_STOPPED" == true ]]; then
  echo "Starting $SERVICE_NAME..."
  systemctl --user start "$SERVICE_NAME"
  SERVICE_STOPPED=false

  if [[ -n "$APP_URL" ]]; then
    echo "Waiting for Next.js to respond on $APP_URL..."
    for _attempt in {1..20}; do
      if curl -fsSI --max-time 2 "$APP_URL" >/dev/null; then
        echo "Next.js is online."
        systemctl --user --no-pager --lines=0 status "$SERVICE_NAME"
        exit 0
      fi

      sleep 1
    done

    echo "Next.js did not respond after 20 seconds. Recent logs:" >&2
    journalctl --user -u "$SERVICE_NAME" --no-pager -n 40
    exit 1
  fi

  systemctl --user --no-pager --lines=0 status "$SERVICE_NAME"
  exit 0
fi

echo "No user service restarted. Start development manually when ready."
