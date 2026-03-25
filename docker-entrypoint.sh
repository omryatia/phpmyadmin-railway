#!/bin/sh
set -eu

echo "Preparing Apache modules for phpMyAdmin..."

a2dismod mpm_event 2>/dev/null || true
a2dismod mpm_worker 2>/dev/null || true
a2enmod mpm_prefork 2>/dev/null || true

echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf
a2enconf servername 2>/dev/null || true

echo "Starting original phpMyAdmin entrypoint..."
exec /docker-entrypoint.sh "$@"
