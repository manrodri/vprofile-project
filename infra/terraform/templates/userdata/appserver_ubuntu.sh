#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-8-jdk -y
sudo apt install tomcat8 tomcat8-admin tomcat8-docs tomcat8-common git awscli -y

# remove ROOT and default tomcat application
cd /var/lib/tomcat8/webapps
sudo systemctl stop tomcat8
sudo rm -r /var/lib/tomcat8/webapps/ROOT

# get artifact from s3
ARTIFACT_NAME='vprofile-v2.war'
S3_BUCKET_NAME=${s3_bucket_name}
sudo aws s3 cp s3://$S3_BUCKET_NAME/$ARTIFACT_NAME /tmp/

# copy artifact to tomcat webapps
cd /tmp
sudo cp $ARTIFACT_NAME /var/lib/tomcat8/webapps/ROOT.war
sudo systemctl start tomcat8
