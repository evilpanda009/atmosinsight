# Atmos Insight - Docker Compose

This repository provides a setup for Opensearch, Opensearch Dashboards, Logstash, Filebeat, and SSL using Docker Compose.

## Directory Structure

 ```
 .
 ├── config
 │   ├── filebeat
 │   │   └── filebeat.yml
 │   ├── logstash
 │   │   ├── config
 │   │   │   ├── logstash.yml
 │   │   │   └── pipelines.yml
 │   │   └── pipeline
 │   │       └── logstash.conf
 │   ├── opensearch
 │   │   └── opensearch.yml
 │   └── opensearch-dashboards
 │       └── opensearch-dashboards.yml
 ├── docker-compose.yml
 ├── scripts
 │   ├── Linux_settings.sh
 │   ├── email_conf.sh
 │   ├── generate_certs.sh
 │   └── update_restart.sh
 └── setup.sh
```

 

## Installation Steps

### Step 1: Clone the Repository

> ```bash
> $ git clone https://github.com/TalhaJuikar/atmosinsight.git
> $ cd atmosinsight
> ```

### Step 2: Configure

Update the necessary configuration files in the `config` directory as needed.

### Step 3: Set Up the Environment

Make the setup script executable and run it:

> ```bash
> $ chmod +x ./setup.sh
> $ bash ./setup.sh
> ```

### Step 4: Access the Dashboard

The Opensearch Dashboard can be accessed at: **https://<machine-ip>:5601**  
Default username: **admin**  
Default password: **admin**

## Updating Configuration

After making changes to any configuration files or `docker-compose.yml`, run the following command to update and restart the services:

> ```bash
> $ bash ./scripts/update_restart.sh
> ```

Adding email username and password to keystore

> ```bash
> $ chmod +x ./scripts/email_conf.sh
> $ bash ./scripts/email_conf.sh
> ```

You will be prompted to enter the details, alternatively you can also input the values via cli

> ```bash
> $ bash ./scripts/email_conf.sh sender_name username password secure_settings_password
> ```