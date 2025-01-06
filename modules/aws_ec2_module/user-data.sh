# user-data script

#!/bin/bash
sleep 30

sudo yum update -y

git clone https://github.com/Sam-Meech-Ward/cocktails.git

sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo yum install -y nodejs

cd ~/cocktails && npm i --only=prod

cat << EOF > /etc/systemd/system/cocktails.service
[Unit]
Description=Cocktails App
After=cloud-final.service

[Service]
WorkingDirectory=/home/ec2-user/cocktails
ExecStart=/usr/bin/node /home/ec2-user/cocktails/server.js
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=cocktails-app
User=ec2-user

[Install]
WantedBy=multi-user.target
WantedBy=cloud-init.target
EOF


sudo systemctl enable cocktails.service
sudo systemctl start cocktails.service