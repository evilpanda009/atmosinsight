#!/bin/bash

HOST_IP=$(hostname -I | awk '{print $1}')

CONFIG_FILE="config/opensearch-dashboards/opensearch-dashboards.yml"

sed -i "s/localhost/$HOST_IP/g" "$CONFIG_FILE"

echo "Replaced localhost with $HOST_IP in $CONFIG_FILE"
