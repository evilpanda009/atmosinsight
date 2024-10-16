# Opensearch-DockerCompose

Opensearch and Opensearch dashboards along with Logstash, Filebeat and ssl using docker compose.
## Directory Structure
.
├── Build
│   └── Dockerfile-dashboard
├── LICENSE
├── Linux_settings.sh
├── README.md
├── config
│   ├── filebeat
│   │   └── filebeat.yml
│   ├── logstash
│   │   └── logstash.conf
│   ├── opensearch
│   │   └── opensearch.yml
│   └── opensearch-dashboards
│       └── opensearch-dashboards.yml
├── docker-compose.yml
├── generate_certs.sh
└── setup.sh

## Step 1:

>     $ git clone https://github.com/TalhaJuikar/Opensearch-DockerCompose.git
>     $ cd Opensearch-DockerCompose

## Step 2:
Update the required configuration files as needed.

## Step 3:

> `$ chmod + ./setup.sh`
> 
> `$ bash ./setup.sh`

## Step 4:
Dashboard is available at **https://machine-ip:5601**
Default username and password is ***admin'***