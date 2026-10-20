#!/usr/bin/env bash
#
# launch.sh - real open data: Boston's bike-share stations and its districts (areas), read from the city's
# CKAN portal (data.boston.gov - needs the network)
#
# Copyright 2026 Seamware
# SPDX-License-Identifier: Apache-2.0
#
# Usage: bikes/launch.sh
#
. "$(dirname "$0")/../lib/demo.sh"

PORT=${PORT:-1092}
URL=http://localhost:$PORT

brokerStart "$PORT"
"$C3/examples/ckan-bikes.sh" "$URL"

hold "$URL"
