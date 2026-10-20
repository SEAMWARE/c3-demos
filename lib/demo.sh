#!/usr/bin/env bash
#
# demo.sh - what the launchers share: find the c3 checkout and coraine, start a broker in RAM, stop
# everything on Ctrl-C
#
# Copyright 2026 Seamware
# SPDX-License-Identifier: Apache-2.0
#
# Sourced by <demo>/launch.sh. Environment: C3 (the c3 checkout, default: ../c3 beside this repository),
# CORAINE (the broker, default: coraine in PATH), PORT (the broker's port; the health port is PORT+1).
#
set -euo pipefail

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
C3=${C3:-$HERE/../c3}
CORAINE=${CORAINE:-coraine}
PIDS=()

die() { echo "$(basename "$0"): $*" >&2; exit 1; }

[ -d "$C3/examples" ] || die "no c3 checkout at $C3 - clone SEAMWARE/c3 beside this repository, or set C3=<dir>"
command -v "$CORAINE" >/dev/null || die "no '$CORAINE' - install coraine (https://github.com/SEAMWARE/coraine/blob/main/doc/installation.md), or set CORAINE=<path>"
command -v curl >/dev/null || die "needs curl"

stopAll() {
  trap - INT TERM EXIT
  for pid in "${PIDS[@]}"; do kill "$pid" 2>/dev/null || true; done
  wait 2>/dev/null || true
  echo "stopped"
}
trap stopAll INT TERM EXIT

#
# brokerStart <port> - coraine in RAM, with its WebSocket transport (c³'s live values), its log in
# /tmp/c3-demo-<port>.log; waits until it is ready
#
brokerStart() {
  local port=$1 log=/tmp/c3-demo-$1.log
  if curl -s -o /dev/null "http://localhost:$port/version"; then die "port $port is in use - PORT=<another>"; fi
  "$CORAINE" -fg -db corDB -p "$port" --healthPort $((port + 1)) --transports ws > "$log" 2>&1 &
  PIDS+=($!)
  for _ in $(seq 100); do
    curl -sf -o /dev/null "http://localhost:$((port + 1))/ready" && return 0
    kill -0 "${PIDS[-1]}" 2>/dev/null || die "coraine did not start - $log"
    sleep 0.1
  done
  die "coraine is not ready after 10 s - $log"
}

#
# hold <url> - say where to connect, and wait for Ctrl-C
#
hold() {
  echo
  echo "  In c³ (Explore), connect to   $1"
  echo "  Ctrl-C stops the demo."
  echo
  wait
}
