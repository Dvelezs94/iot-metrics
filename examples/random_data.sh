#!/bin/bash

INFLUXDB_URL="http://localhost:8086/write?db=iot_metrics"
METRIC="random_data"
HOST=$(hostname)
INTERVAL=0 # seconds between measurements

while true; do
  # Generate random data (0-100)
  RANDOM_DATA=$((RANDOM % 101))
  
  # Line Protocol: measurement,tag1=value1 field=value timestamp(optional)
  LINE="$METRIC,host=$HOST value=$RANDOM_DATA"
  
  # Send to InfluxDB
  curl -s -i -XPOST "$INFLUXDB_URL" --data-binary "$LINE" >/dev/null
  
  echo "[$(date)] Sent Random data = $RANDOM_DATA"
  
  sleep $INTERVAL
done
