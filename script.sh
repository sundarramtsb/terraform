#! /bin/bash
sudo yum update -y
sudo yum install httpd -y
echo "Hello from terraform" > /var/www/html/index.html
service httpd restart