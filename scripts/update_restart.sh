# Start the Docker containers
docker compose up -d

# Wait for 30 seconds
sleep 30

# Run the command in the specified container
docker compose exec os01 bash -c "chmod +x plugins/opensearch-security/tools/securityadmin.sh && \
bash plugins/opensearch-security/tools/securityadmin.sh -cd config/opensearch-security -icl -nhnv \
-cacert config/certificates/ca/ca.pem -cert config/certificates/ca/admin.pem -key config/certificates/ca/admin.key -h localhost"