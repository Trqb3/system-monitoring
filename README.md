# System Monitoring 🐋

## Overview
This project provides a comprehensive system monitoring solution using Docker containers. It includes popular monitoring tools such as [Grafana](https://grafana.com/), [Prometheus](https://prometheus.io/), and [Loki](https://grafana.com/oss/loki/), all configured to work together seamlessly.

Logging and monitoring are essential for maintaining the health and performance of your systems. This stack allows you to visualize metrics, set up alerts, and analyze logs in a unified interface.

Possible use cases include:
- Monitoring server performance and resource usage
- Visualizing application metrics
- Centralized log management and analysis
- Monitoring containerized applications
- Uptime monitoring for websites and services

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