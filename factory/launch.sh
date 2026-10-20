#!/usr/bin/env bash
#
# launch.sh - the factory floor: 25 entities with Relationships, locations, areas and routes, and its
# robots at work - their speed, battery and position change every 0.5 s
#
# Copyright 2026 Seamware
# SPDX-License-Identifier: Apache-2.0
#
# Usage: factory/launch.sh [sensors]     sensors: that many more entities, to page through (default 0)
#
. "$(dirname "$0")/../lib/demo.sh"

PORT=${PORT:-1090}
URL=http://localhost:$PORT

brokerStart "$PORT"
"$C3/examples/factory.sh" "$URL"
[ "${1:-0}" -gt 0 ] && "$C3/examples/factory.sh" "$URL" "$1"
"$C3/examples/live.sh" "$URL" > /tmp/c3-demo-live.log 2>&1 &
PIDS+=($!)

hold "$URL"
