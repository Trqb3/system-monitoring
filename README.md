# System Monitoring

## Installation Guide
Make sure you have [Git](https://git-scm.com/install/linux) and [Docker](https://docs.docker.com/engine/install/) installed on your system.
To install the System Monitoring Stack, follow these steps:

```bash
# Clone repository
git clone https://github.com/Trqb3/system-monitoring.git

# Navigate to the project directory and run the setup script and follow the prompts
cd system-monitoring && ./setup.sh
```

Check out `monit.conf` for further configuration details.

Make sure to copy the Grafana login credentials from the setup output. In case you missed them, you can find them in the `monit.conf` file located in the project directory.

In Ordner to finally start the docker stack, run:

```bash
docker-compose up -d
```

## Getting Started
Once the setup is complete, you can access the monitoring dashboard by navigating to `http://localhost:3000` in your web browser. This url may vary based on your configuration.

Use the Grafana credentials provided during the setup to log in.

Datasources like Prometheus and Loki are pre-configured, so you can start exploring the dashboards right away.