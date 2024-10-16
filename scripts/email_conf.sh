#!/bin/bash

# Variables
# SENDER_NAME="<sender_name>"  # Replace with actual sender name
# USERNAME="<username>"         # Replace with actual username
# PASSWORD="<password>"         # Replace with actual password
# SECURE_SETTINGS_PASSWORD="1234"  # Replace with the actual secure settings password

# Prompt for user input
prompt_for_input() {
    read -p "$1: " input
    echo "$input"
}

# Check for command-line arguments and assign them to variables
if [ $# -ge 4 ]; then
    SENDER_NAME="$1"
    USERNAME="$2"
    PASSWORD="$3"
    SECURE_SETTINGS_PASSWORD="$4"
else
    # Prompting for variables if not provided via command line
    SENDER_NAME=$(prompt_for_input "Enter sender name")
    USERNAME=$(prompt_for_input "Enter email username")
    PASSWORD=$(prompt_for_input "Enter email password")
    SECURE_SETTINGS_PASSWORD=$(prompt_for_input "Enter secure settings password")
fi


# Function to add credentials to the keystore
add_to_keystore() {
    echo "Adding email username to keystore..."
    /usr/share/opensearch/bin/opensearch-keystore add opensearch.notifications.core.email.$SENDER_NAME.username <<< "$USERNAME"
    
    echo "Adding email password to keystore..."
    /usr/share/opensearch/bin/opensearch-keystore add opensearch.notifications.core.email.$SENDER_NAME.password <<< "$PASSWORD"
}

# Function to reload secure settings
reload_secure_settings() {
    echo "Reloading secure settings..."
    curl -X POST "http://localhost:9200/_nodes/reload_secure_settings" -H "Content-Type: application/json" -d '{
        "secure_settings_password": "'"$SECURE_SETTINGS_PASSWORD"'"
    }'
}

# Main execution
add_to_keystore
reload_secure_settings

echo "Credentials added and secure settings reloaded."
