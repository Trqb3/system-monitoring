#!/bin/bash

echo "Monitoring Stack Configuration Generator"
echo "========================================"
echo ""

if [ -f monit.conf ]; then
  read -p "A configuration file was found. Do you want to overwrite it? [y/N]: " response
  case $response in
    [yY][eE][sS]|[yY])
      mv monit.conf monit.conf_backup
      chmod 600 monit.conf_backup     ;;
    *)
      exit 1
    ;;
  esac
fi


if [ -a /etc/timezone ]; then
  DETECTED_TZ=$(cat /etc/timezone)
elif [ -a /etc/localtime ]; then
  DETECTED_TZ=$(readlink /etc/localtime|sed -n 's|^.*zoneinfo/||p')
fi

while [ -z "${TZ}" ]; do
  if [ -z "${DETECTED_TZ}" ]; then
    read -p "Timezone: " -e TZ
  else
    read -p "Timezone [${DETECTED_TZ}]: " -e TZ
    [ -z "${TZ}" ] && TZ=${DETECTED_TZ}
  fi
done


read -p "Grafana bind Port [3000]: " -e GRAFANA_PORT
read -p "Grafana Admin User [admin]: " -e GRAFANA_USER
GRAFANA_PASS=$(openssl rand -base64 32)


cat > monit.conf <<EOF
# Generated on $(date -u +"%Y-%m-%d %H:%M:%S") UTC
# by ${USER}

# ------------------------------------------------------------
# Docker project configuration
# ------------------------------------------------------------
# Project Name
# Use lowercase letters only
PROJECT_NAME=monitoring

# Version of Docker Stack
# Can be left as '1' when no other instances are installed
PROJECT_VERSION=1

# ------------------------------------------------------------
# Other configurations
# ------------------------------------------------------------
# Your timezone
# See https://en.wikipedia.org/wiki/List_of_tz_database_time_zones for a list of timezones
# Use the column named 'TZ identifier'
TZ=${TZ}

# ------------------------------------------------------------
# Grafana configuration
# ------------------------------------------------------------
# Bind configuration for Grafana web ui
# Do not put the port behind the bind
# Example: GRAFANA_BIND=1.2.3.4
# Default bind is 0.0.0.0
# Default port is 3000
GRAFANA_PORT=${GRAFANA_PORT}
GRAFANA_BIND=

# Grafana Admin user data can be set here
# Default username is admin
# Default password is admin
GRAFANA_USER=${GRAFANA_USER}
GRAFANA_PASS=${GRAFANA_PASS}
EOF


# Symlink für .env
rm -f .env
ln -s monit.conf .env


echo ""
echo "✓ Configuration created!"
echo ""
echo "Grafana credentials:"
echo "  User: ${GRAFANA_USER:-admin}"
echo "  Password: ${GRAFANA_PASS}"
echo ""
echo "Start with: docker compose up -d"