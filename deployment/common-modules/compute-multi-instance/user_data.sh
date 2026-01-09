#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# --- 1. Update and Install Python/Dependencies ---
# Use yum for Amazon Linux/RHEL-based AMIs
yum update -y

# Ensure Python 3 and pip are installed
yum install -y python3 python3-pip git

# --- 2. Create Application Directory and User ---
APP_DIR="/opt/my_python_app"
APP_USER="webappuser"

# Create a dedicated user and directory for security
useradd -m -s /bin/bash $APP_USER
mkdir -p $APP_DIR
chown -R $APP_USER:$APP_USER $APP_DIR

# --- 3. Fetch Application Code ---
cd $APP_DIR
# Remove any existing .git directory to avoid permission issues
rm -rf .git
sudo -u $APP_USER git config --global --add safe.directory $APP_DIR
sudo -u $APP_USER git init
# Add the remote
sudo -u $APP_USER git remote add origin https://github.com/radhikadate/terraform-app-deployments.git
# Enable sparse checkout
sudo -u $APP_USER git config core.sparseCheckout true
# Define which folder you want to "archive" or extract
sudo -u $APP_USER bash -c 'echo "hello-world-app/" >> .git/info/sparse-checkout'
# Pull only that directory (depth 1 saves bandwidth)
sudo -u $APP_USER git pull --depth=1 origin main

sudo -u $APP_USER python3 -m venv venv
sudo -u $APP_USER bash -c 'source venv/bin/activate && pip install -r hello-world-app/requirements.txt'

cat > /etc/systemd/system/mywebapp.service << EOF
[Unit]
Description=My Python Web Application
After=network.target

[Service]
# User/Group to run the application as
User=$APP_USER
Group=$APP_USER
# Change to the application directory
WorkingDirectory=$APP_DIR
# Command to run the application (e.g., a Flask/Gunicorn/uvicorn startup)
ExecStart=$APP_DIR/venv/bin/python $APP_DIR/hello-world-app/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable, and start the service
systemctl daemon-reload
systemctl enable mywebapp
systemctl start mywebapp

echo "Application setup complete!"