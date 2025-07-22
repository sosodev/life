#!/bin/bash

# This script watches for git updates and redeploys the application when they are found.
# It's a simple deployment script for a single-server setup.

# Exit immediately if a command exits with a non-zero status.
set -e

# The server process ID
SERVER_PID=""

# Function to start the server
start_server() {
    echo "Starting Rails server in production mode..."
    bundle exec rails server -e production &
    SERVER_PID=$!
    echo "Server started with PID: $SERVER_PID"
}

# Function to stop the server
stop_server() {
    if [ -n "$SERVER_PID" ]; then
        echo "Stopping server with PID: $SERVER_PID..."
        # Kill the process and any of its children
        kill -TERM $SERVER_PID
        # Wait for the process to terminate
        wait $SERVER_PID 2>/dev/null
        echo "Server stopped."
    fi
    SERVER_PID=""
}

# Function to deploy updates
deploy() {
    echo "Stopping server for deployment..."
    stop_server

    echo "Pulling latest changes..."
    git pull

    echo "Installing dependencies..."
    bundle install --without development test

    echo "Running database migrations..."
    RAILS_ENV=production bundle exec rails db:migrate

    echo "Precompiling assets..."
    RAILS_ENV=production bundle exec rails assets:precompile

    start_server
}

# Graceful shutdown
trap 'echo "Shutting down watcher..."; stop_server; exit 0' SIGINT SIGTERM

# Initial setup and server start
echo "Performing initial setup..."
git fetch # Fetch to ensure we have remote info
deploy

# Main loop to watch for updates
while true; do
    echo "Watching for updates... (checking in 60 seconds)"
    sleep 60

    # Fetch the latest changes from the remote
    git fetch

    LOCAL=$(git rev-parse HEAD)
    REMOTE=$(git rev-parse @{u})

    if [ "$LOCAL" != "$REMOTE" ]; then
        echo "New commits found on remote. Redeploying..."
        deploy
    else
        echo "No new updates."
    fi
done
