#!/bin/bash

sudo yum update -y

#-------------git install--------------
sudo yum install git -y

#-------java dependency for jenkins--------
sudo yum install java-21-amazon-corretto.x86_64

#-------------jenkins install--------------
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins