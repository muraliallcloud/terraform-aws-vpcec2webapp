#!/bin/sh
#install httpd
yum -y update
yum -y install httpd
systemctl start httpd
systemctl enable httpd
chmod 777 /var/www/html
EC2_AVAIL_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
sudo echo "<h1>Hello World from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h1>" > /var/www/html/index.html
useradd ansadmin
echo "Crazy@123" | passwd --stdin ansadmin
echo "ansadmin	ALL=(ALL)	NOPASSWD:ALL" >> /etc/sudoers
sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart
sudo mkdir /var/www/html/app1
sudo chmod 777 /var/www/html/app1
sudo echo "<h1>Hello World from $(hostname -f) in AZ $EC2_AVAIL_ZONE</h1> <br><br><br> <h2>Application: App1<h2><br><br><h2>Welcome to Application1<h2>" > /var/www/html/app1/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html