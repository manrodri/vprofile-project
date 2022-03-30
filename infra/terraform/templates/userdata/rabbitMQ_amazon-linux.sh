#!/bin/bash
sudo amazon-linux-extras install epel -y
sudo yum update -y

curl -1sLf   'https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/setup.rpm.sh'   | sudo -E bash

sudo yum -y install erlang socat
sudo yum install rabbitmq-server -y
sudo systemctl rabbitmq-server
sudo systemctl enable --now rabbitmq-server
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server


# dns
HOSTED_ZONE_ID=${hosted_zone_id}

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

DOMAIN_NAME=$(aws route53 get-hosted-zone --id "$HOSTED_ZONE_ID" --query 'HostedZone.Name' --output text | sed 's/.$//')
aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --change-batch '{"Changes": [{"Action": "UPSERT","ResourceRecordSet": {"Name": "'rmq01.vprofile.in'","Type": "A","TTL": 60,"ResourceRecords": [{"Value": "'"$PRIVATE_IP"'"}]}}]}'