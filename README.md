# Solar Assistant Grid Voltage Monitor

This script continuously monitors your grid voltage via MQTT from Solar Assistant and sends real-time notifications to your device using [ntfy.sh](https://ntfy.sh). Perfect for off-grid and backup power systems where you need instant alerts about power status changes.

---

## Features

✅ **Live MQTT Monitoring** - Subscribes to your Solar Assistant's MQTT broker for real-time grid voltage updates  
✅ **Smart Notifications** - Sends push alerts via ntfy when grid power is lost or restored  
✅ **No Alert Spam** - Only notifies you on state changes, preventing redundant notifications  
✅ **Lightweight** - Simple bash script that runs on minimal resources  

---

## Prerequisites

- **Solar Assistant** appliance running with MQTT enabled (e.g., on Raspberry Pi)
- **MQTT Credentials** - Username and password for your Solar Assistant MQTT broker
- **MQTT Topic** - The grid voltage topic from your inverter (e.g., `solar_assistant/inverter_1/grid_voltage/state`)
- **ntfy App** - Installed on your phone/device, or access to ntfy.sh
- **Linux/Unix System** with:
  - `mosquitto-clients` (for `mosquitto_sub`)
  - `curl` (for HTTP requests)

---

## Installation

### 1. Download the Script

```bash
wget https://raw.githubusercontent.com/mattadata/Solar-Assistant-Notifier/main/monitor_grid.sh
chmod +x monitor_grid.sh