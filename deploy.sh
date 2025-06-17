#!/bin/zsh

# Deploy script to connect to life.local and run commands
ssh kyle@life.local << 'EOF'
    echo "Connected to life.local"
    
    # Navigate to application directory (adjust path as needed)
    cd /path/to/your/app
    
    # Pull latest changes
    git pull origin main
    
    # Install/update dependencies
    bundle install
    
    # Run database migrations
    rails db:migrate
    
    # Precompile assets
    rails assets:precompile
    
    # Restart the application (adjust service name as needed)
    sudo systemctl restart your-app-service
    
    echo "Deployment completed successfully"
EOF

echo "Disconnected from life.local"

