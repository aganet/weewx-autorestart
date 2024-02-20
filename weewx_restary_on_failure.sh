#!/bin/bash
# Define the name of the service
service_name="weewx"

current_time=$(date +%Y-%m-%d\ %T)
message="WEEWX was found stopped and restarted at: $current_time"

# Check the status of the service
status=$(systemctl show $service_name | grep "SubState")

# If the status is "exited" or "failed", restart the service
if [ "$status" == "SubState=exited" ] || [ "$status" == "SubState=failed" ]; then
  systemctl stop $service_name
  sleep 10
  systemctl start $service_name
  echo "$message" >> /var/log/weewx_restart.log
fi
