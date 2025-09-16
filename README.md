# IOT Metrics

This project aims to give some observability on IoT projects, by providing an easy way to visualize and explore metrics coming from devices such as Arduino, ESP32, Raspberry Pi, and other hardware.

It uses **InfluxDB** for time-series storage and **Grafana** for visualization, making it simple to collect, store, and analyze device telemetry in real time.

---

## 🚀 Features
- Plug-and-play **Docker Compose** setup (InfluxDB + Grafana)
- Supports high-frequency data from IoT devices
- Ready for **millisecond resolution metrics**
- Works with simple HTTP requests (`curl`), Arduino, ESP8266/ESP32, Raspberry Pi, etc.
- Persistent storage using Docker volumes
- Out-of-the-box Grafana dashboards

---

## 🛠️ Getting Started

### Prerequisites
- Docker
- Docker Compose

### Run the stack
```bash
docker compose up -d
```

## Access Grafana

1. Open http://localhost:3000

2. Login with:
```
Username: admin
Password: admin
```

3. Create your first dashboard or import prebuilt IoT dashboards from Grafana Labs.

### Pushing Data to InfluxDB

#### Using HTTP API (curl)

You can send metrics directly to InfluxDB using the Line Protocol:

```
curl -i -XPOST "http://localhost:8086/write?db=iot_metrics" --data-binary "temperature,sensor=esp32 value=23.5"
```

`temperature` → measurement name

`sensor=esp32` → tag identifying the device

`value=23.5` → actual sensor value