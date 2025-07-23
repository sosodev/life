#!/bin/bash
set -e

# Copies the production database to or from the remote server.
# Usage: $0 <to|from>

if [ "$1" = "from" ]; then
  sftp kyle@life.local:/home/kyle/life/storage/production.sqlite3 .
elif [ "$1" = "to" ]; then
  sftp kyle@life.local <<EOF
put production.sqlite3 /home/kyle/life/storage/production.sqlite3
EOF
else
  echo "Usage: $0 <to|from>"
  exit 1
fi
