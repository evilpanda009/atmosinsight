#!/bin/bash

# Run Linux settings script
chmod +x ./scripts/Linux_settings.sh
bash ./scripts/Linux_settings.sh

# Run the certificate generation script
chmod +x ./scripts/generate_certs.sh
bash ./scripts/generate_certs.sh

# Update opensearch-dashboards.yml with host IP
chmod +x ./scripts/add_ip.sh
bash ./scripts/add_ip.sh

# Start the Docker containers
docker compose up -d

# Wait for 30 seconds
sleep 30

# Run the command in the specified container
docker compose exec os01 bash -c "chmod +x plugins/opensearch-security/tools/securityadmin.sh && \
bash plugins/opensearch-security/tools/securityadmin.sh -cd config/opensearch-security -icl -nhnv \
-cacert config/certificates/ca/ca.pem -cert config/certificates/ca/admin.pem -key config/certificates/ca/admin.key -h localhost"
