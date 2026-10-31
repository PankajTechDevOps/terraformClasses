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
--------------------------------------------


/* Download Jenkins from the alternative mirror
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y

# if any issue then follow below commands
curl -fIL https://mirrors.huaweicloud.com/jenkins/rpm-stable/jenkins-2.580.2-1.noarch.rpm
curl -fL -o /tmp/jenkins.rpm https://mirrors.huaweicloud.com/jenkins/rpm-stable/jenkins-2.580.2-1.noarch.rpm
rpm --checksig --verbose /tmp/jenkins.rpm
sudo dnf install -y /tmp/jenkins.rpm
sudo systemctl enable --now jenkins
sudo systemctl status jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
*/


#--------get password--------------------------
cat /var/lib/jenkins/secrets/initialAdminPassword

# --------------------install terraform --------------------

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

terraform -version
