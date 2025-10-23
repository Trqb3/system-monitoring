# 🐋 System Monitoring

## 🌟 Overview
This project provides a comprehensive system monitoring solution using Docker containers.

### 🎯 Use Cases
- 📈 Monitor server performance and resource usage
- 📊 Visualize application metrics
- 📝 Centralized log management
- 🐳 Container monitoring
- ⏱️ Uptime monitoring

## 🏗️ Architecture
This stack includes the following components:
- **[Grafana](https://github.com/grafana/grafana)** - Visualization and dashboarding
- **[Prometheus](https://github.com/prometheus/prometheus)** - Metrics collection and storage
- **[Loki](https://github.com/grafana/loki)** - Log aggregation system
- **[Promtail](https://grafana.com/docs/loki/latest/send-data/promtail/)** - Log shipping agent for Loki
- **[Node Exporter](https://github.com/prometheus/node_exporter)** - System metrics exporter for Prometheus
- **[cAdvisor](https://github.com/google/cadvisor)** - Container resource usage and performance analysis
- **[Blackbox Exporter](https://github.com/prometheus/blackbox_exporter)** - Uptime monitoring for endpoints

All services run in isolated Docker containers and communicate through a dedicated network.

## ⚙️ Prerequisites
- 🐙 Git installed ([Installation guide](https://git-scm.com/install/linux))
- 🐳 Docker & Docker Compose ([Installation guide](https://docs.docker.com/engine/install/))
- 💾 Minimum 2GB RAM
- 📦 10GB disk space

## 🚀 Installation
```bash
# Clone the repository
git clone https://github.com/Trqb3/system-monitoring.git

# Navigate to the project directory
cd system-monitoring

# Run the setup script
./setup.sh

# Start the stack
docker compose up -d
```

## 🔧 Configuration
Edit `monit.conf` to customize your setup.

> 💡 **Tip**: Save your Grafana credentials from the setup output!

## 💻 Getting Started
Once the setup is complete, you can access the monitoring dashboard by navigating to `http://localhost:3000` in your web browser.
> 📌 **Note**: URLs may vary based on your configuration

Use the Grafana credentials provided during the setup to log in.

Datasources like Prometheus and Loki are pre-configured, so you can start exploring the dashboards right away.

## 🛠️ Troubleshooting

### 🐛 Containers won't start
```bash
docker compose logs
```

### 🔑 Forgot credentials?
Check the `monit.conf` file in your project directory.