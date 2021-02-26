#!/bin/bash
sudo su
sudo yum -y update

echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk

echo "Pre - Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "Install Jenkins"
sudo yum install -y jenkins

echo "Start Docker"
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins


echo "Download Terrafrom"
export TERRAFORM_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip

echo "install Unzip"
sudo yum -y install unzip

echo "Unzip terraform"
unzip terraform_${TERRAFORM_VER}_linux_amd64.zip

echo "Move binary file to the /usr/local/bin directory"
sudo mv terraform /usr/local/bin/
