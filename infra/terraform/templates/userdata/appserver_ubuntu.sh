#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-8-jdk -y
sudo apt install tomcat8 tomcat8-admin tomcat8-docs tomcat8-common git awscli -y

# get artifact from s3
ARTIFACT_NAME='FOO'
S3_BUCKET_NAME='BAR'
aws s3 cp s3://${S3_BUCKET_NAME}/${ARTIFACT_NAME} /tmp/

cd /tmp
cp ${ARTIFACT_NAME} /var/lib/tomcat8/webapps/ROOT.war
systemct start tomcat8
