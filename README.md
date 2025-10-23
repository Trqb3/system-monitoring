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

Check out ``monit.conf`` for further configuration details.
In Ordner to finally start the docker stack, run:

```bash
docker-compose up -d
```