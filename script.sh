#!/bin/bash

# Update system
apt update -y

# Install required packages
apt install -y python3-pip nginx git

# Install Flask
pip3 install flask

# Go to home directory
cd /home/adminvmss

# Clone your repo
git clone https://github.com/faridanjum-sudo/hangman

cd hangman

# Run app in background
nohup python3 app.py > app.log 2>&1 &

# Configure Nginx
cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80 default_server;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

# Restart Nginx
systemctl restart nginx