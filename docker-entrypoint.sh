#!/bin/bash
#set -euo pipefail
mv /usr/src/wordpress/* /var/www/html/
chown www-data:www-data $PWD
exec "$@"
