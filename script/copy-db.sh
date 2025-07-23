#!/bin/bash
set -e

# Copies the production database from the remote server.
# Replace `user@remote-host` with your actual remote user and hostname.
sftp user@remote-host:/home/kyle/life/storage/production.sqlite3 .
