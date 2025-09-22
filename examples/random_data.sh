#!/bin/bash

INFLUXDB_URL="http://localhost:8086/api/v2/write?org=my-org&bucket=sensors&precision=us"
AUTH_TOKEN="my-super-secret-token"
METRIC="random_data"
HOST=$(hostname)
INTERVAL=0 # seconds between measurements

while true; do
  # Generate random data (0-100)
  RANDOM_DATA=$((RANDOM % 101))
  
  # Line Protocol: measurement,tag1=value1 field=value timestamp(optional)
  LINE="$METRIC,host=$HOST value=$RANDOM_DATA"
  
  # Send to InfluxDB
  curl -s -i -XPOST "$INFLUXDB_URL" \
  --header "Authorization: Token $AUTH_TOKEN" \
  --data-raw "$LINE" > /dev/null
  
  echo "[$(date)] Sent Random data = $RANDOM_DATA"
  
  sleep $INTERVAL
done
