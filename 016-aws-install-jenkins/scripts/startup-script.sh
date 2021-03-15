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

echo "install Unzip"
sudo yum -y install unzip

