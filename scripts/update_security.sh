docker compose exec os01 bash -c "chmod +x plugins/opensearch-security/tools/securityadmin.sh && \
bash plugins/opensearch-security/tools/securityadmin.sh -cd config/opensearch-security -icl -nhnv \
-cacert config/certificates/ca/ca.pem -cert config/certificates/ca/admin.pem -key config/certificates/ca/admin.key -h localhost"