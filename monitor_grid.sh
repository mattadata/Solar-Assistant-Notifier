#!/bin/bash

# Configuration
USER="" #enter your Solar Assistant MQTT username
PASS="" #enter your Solar Assistant MQTT password
TOPIC="solar_assistant/inverter_1/grid_voltage/state"   #This was my topic name on EG4 12000XP. You can use MQTTX on your computere to look at all topics available
NTFY_TOPIC="" #enter the notification topic for the NTFY app

# Initial State: Assume grid is UP to start
# (This prevents a notification the second you start the script)
grid_status="UP"

echo "Monitoring Grid Voltage... Press [CTRL+C] to stop."

mosquitto_sub -u "$USER" -P "$PASS" -t "$TOPIC" | while read value; do
  # Use 'bc' to handle decimal numbers if present, or basic integer comparison
  # We convert to an integer for simplicity
  voltage=${value%.*} 

  # LOGIC: Grid goes DOWN
  if [[ "$grid_status" == "UP" ]] && [[ "$voltage" -lt 100 ]]; then
    curl -H "Title: Grid Power LOST" -H "Priority: urgent" -H "Tags: alert,skull" \
         -d "The grid voltage has dropped to $value V." \
         "ntfy.sh/$NTFY_TOPIC"
    grid_status="DOWN"
    echo "$(date): Grid went down ($value V)"

  # LOGIC: Grid comes BACK UP
  elif [[ "$grid_status" == "DOWN" ]] && [[ "$voltage" -ge 210 ]]; then
    curl -H "Title: Grid Power RESTORED" -H "Priority: high" -H "Tags: white_check_mark,zap" \
         -d "The grid is back! Voltage is $value V." \
         "ntfy.sh/$NTFY_TOPIC"
    grid_status="UP"
    echo "$(date): Grid restored ($value V)"
  fi
done
