#!/bin/bash

OPENTSDB_URL="http://localhost:4242/api/put"
METRIC="system.cpu.usage"
HOST=$(hostname)
TIMEOUT=0 # seconds

while true; do
  # Get CPU usage percentage (average over 1 second)
  CPU=$(mpstat 1 1 | awk '/Average:/ {print 100 - $12}')
  
  # Current timestamp (seconds since epoch)
  TS=$(date +%s)
  
  # JSON payload
  JSON=$(cat <<EOF
{
  "metric": "$METRIC",
  "timestamp": $TS,
  "value": $CPU,
  "tags": {
    "host": "$HOST"
  }
}
EOF
)
  
  # Send to OpenTSDB
  curl -s -X POST -H "Content-Type: application/json" -d "$JSON" "$OPENTSDB_URL" >/dev/null
  
  echo "[$(date)] Sent CPU usage = $CPU%"
  
  sleep $TIMEOUT
done

