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

read -p "Enable SMTP for Grafana email notifications? [y/N]: " SMTP_ENABLED
case $SMTP_ENABLED in
  [yY][eE][sS]|[yY])
    SMTP_ENABLED=true
    ;;
  *)
    SMTP_ENABLED=false
    ;;
esac

if [ "${SMTP_ENABLED}" = "true" ]; then
  read -p "SMTP Host (e.g., smtp.example.com): " -e SMTP_HOST
  read -p "SMTP Port [587]: " -e SMTP_PORT
  SMTP_PORT=${SMTP_PORT:-587}

  read -p "SMTP User: " -e SMTP_USER
  read -s -p "SMTP Password: " -e SMTP_PASS

  read -p "SMTP From Address (e.g., noreply@example.com): " -e SMTP_FROM_ADDRESS
  read -p "SMTP From Name [Grafana]: " -e SMTP_FROM_NAME
  SMTP_FROM_NAME=${SMTP_FROM_NAME:-Grafana}

  read -p "Skip TLS Verification? [y/N]: " SMTP_SKIP_VERIFY
  case $SMTP_SKIP_VERIFY in
    [yY][eE][sS]|[yY])
      SMTP_SKIP_VERIFY=true
      ;;
    *)
      SMTP_SKIP_VERIFY=false
      ;;
  esac
fi



read -p "Grafana bind Port [3000]: " -e GRAFANA_PORT
GRAFANA_PORT=${GRAFANA_PORT:-3000}

read -p "Grafana Admin User [admin]: " -e GRAFANA_USER
GRAFANA_USER=${GRAFANA_USER:-admin}

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
GRAFANA_USER=${GRAFANA_USER}
GRAFANA_PASS=${GRAFANA_PASS}


# Grafana SMTP configuration
# SMTP is disabled by default
# To enable it, set SMTP_ENABLED to 'true' and fill in the other variables
SMTP_ENABLED=${SMTP_ENABLED}

# Hostname or IP address of your SMTP server followed by the port
# Example:  SMTP_HOST=smtp.example.com
SMTP_HOST=${SMTP_HOST}
SMTP_PORT=${SMTP_PORT}

SMTP_USER=${SMTP_USER}
SMTP_PASS=${SMTP_PASS}

# The email address and name to use when sending emails from Grafana
SMTP_FROM_ADDRESS=${SMTP_FROM_ADDRESS}
SMTP_FROM_NAME=${SMTP_FROM_NAME}

# Set to 'true' to skip TLS verification (not recommended)
SMTP_SKIP_VERIFY=${SMTP_SKIP_VERIFY}


# ------------------------------------------------------------
# Prometheus configuration
# ------------------------------------------------------------
# Bind configuration for Prometheus web ui
# Do not put the port behind the bind
# Example: PROMETHEUS_BIND=1.2.3.4
# Default bind is localhost
# Default port is 3000
PROMETHEUS_PORT=9090
PROMETHEUS_BIND=
EOF


# Symlink für .env
rm -f .env
ln -s monit.conf .env


echo ""
echo "✓ Configuration created!"
echo ""
echo "Grafana credentials: "
echo "  User: ${GRAFANA_USER}"
echo "  Password: ${GRAFANA_PASS}"
echo ""
echo "Start with: docker compose up -d"