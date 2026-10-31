#!/bin/bash

sudo yum update -y

#-------------git install--------------
sudo yum install git -y

#-------java dependency for jenkins--------
sudo yum install java-21-amazon-corretto.x86_64

#-------------Amazon Linux 2023----jenkins install--------------
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

#--------get password--------------------------
cat /var/lib/jenkins/secrets/initialAdminPassword

#-------------ubuntu----jenkins install--------------
sudo apt update
sudo apt upgrade -y
sudo apt install -y fontconfig openjdk-21-jre
java -version
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins
sudo systemctl daemon-reload
sudo systemctl enable --now jenkins
sudo systemctl status jenkins --no-pager
java -version
sudo ss -lntp | grep 8080
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# --------------------install terraform --------------------

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

terraform -version
