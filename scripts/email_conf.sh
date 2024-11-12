#!/bin/bash

set -u
set -o pipefail

CONTAINER_NAME="os01"

prompt_for_input() {
    read -p "$1: " input
    echo "$input"
}

prompt_for_password() {
    systemd-ask-password --echo=no --emoji=no "$1:"
}

# Check for command-line arguments and assign them to variables
if [ $# -ge 3 ]; then
    SENDER_NAME="$1"
    USERNAME="$2"
    PASSWORD="$3"
    KESTORE_PASSWORD="$4"
    ADMIN_PASSWORD="$5"
else
    # Prompting for variables if not provided via command line
    SENDER_NAME=$(prompt_for_input "Enter sender name")
    USERNAME=$(prompt_for_input "Enter email username")
    PASSWORD=$(prompt_for_password "Enter email password")
    KESTORE_PASSWORD=$(prompt_for_password "Enter the keystore password")
    ADMIN_PASSWORD=$(prompt_for_password "Enter admin password")
fi


add_to_keystore() {
    echo "Adding email username to keystore inside the container..."
    docker compose exec -it "$CONTAINER_NAME" bash -c "echo -e \"$KESTORE_PASSWORD\\n$USERNAME\" | /usr/share/opensearch/bin/opensearch-keystore add opensearch.notifications.core.email.$SENDER_NAME.username"
    
    echo "Adding email password to keystore inside the container..."
    docker compose exec -it "$CONTAINER_NAME" bash -c "echo -e \"$KESTORE_PASSWORD\\n$PASSWORD\" | /usr/share/opensearch/bin/opensearch-keystore add opensearch.notifications.core.email.$SENDER_NAME.password"
}


set_keystore_password() {
    echo "Checking if the keystore is already password protected..."
    docker compose exec -it "$CONTAINER_NAME" bash -c "echo -e \"$KESTORE_PASSWORD\\n\" | /usr/share/opensearch/bin/opensearch-keystore has-passwd" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Keystore is already password protected. No need to set the password."
    else
        echo "Keystore is not password protected. Setting keystore password..."
        docker compose exec -it "$CONTAINER_NAME" bash -c "echo -e \"$KESTORE_PASSWORD\\n$KESTORE_PASSWORD\" | /usr/share/opensearch/bin/opensearch-keystore passwd"
    fi
}


reload_secure_settings() {
    echo "Reloading secure settings inside the container..."
    docker compose exec -it "$CONTAINER_NAME" curl -k -X POST "https://localhost:9200/_nodes/reload_secure_settings" \
        -H "Content-Type: application/json" \
        -d '{
            "secure_settings_password": "'"$KESTORE_PASSWORD"'"
        }' \
        -u "admin:$ADMIN_PASSWORD"
}


set_keystore_password
add_to_keystore
reload_secure_settings

echo "Keystore password set, credentials added, and secure settings reloaded inside the container."
