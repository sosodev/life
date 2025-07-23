#!/bin/bash
set -e

# Copies the production database from the remote server.
sftp kyle@life.local:/home/kyle/life/storage/production.sqlite3 .

