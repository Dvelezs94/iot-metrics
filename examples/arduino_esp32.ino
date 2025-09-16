#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
const char* influx_url = "http://YOUR_SERVER_IP:8086/write?db=iot_metrics";

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) delay(500);
}

void loop() {
  if(WiFi.status() == WL_CONNECTED){
    HTTPClient http;
    http.begin(influx_url);
    int sensorValue = analogRead(34); // Example sensor
    String data = "temperature,sensor=esp32 value=" + String(sensorValue);
    http.POST(data);
    http.end();
  }
  delay(5000); // send every 5 seconds
}
