#!/bin/zsh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
PORT="8765"
URL="http://127.0.0.1:${PORT}/"

cd "$ROOT_DIR"

python3 -m http.server "$PORT" >/dev/null 2>&1 &
SERVER_PID=$!

cleanup(){
  kill "$SERVER_PID" >/dev/null 2>&1 || true
}

trap cleanup EXIT INT TERM

printf 'Editor running at %s\n' "$URL"
open "$URL" >/dev/null 2>&1 || true

wait "$SERVER_PID"