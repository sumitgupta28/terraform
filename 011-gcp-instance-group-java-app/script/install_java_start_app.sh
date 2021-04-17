#! /bin/bash

echo "*****    Installing Nginx    *****"
sudo apt update
sudo apt install -y default-jre

echo "*****   Installation Complteted!!   *****"

echo "Copy Jar"
mkdir /home/$USER/app
gsutil cp gs://sumitgupta28-code-bucket/*.jar /home/$USER/app/

echo "Start"
java -jar /home/$USER/app/ocp-demo-app-*.jar 
echo "*****   Startup script completes!!    *****"