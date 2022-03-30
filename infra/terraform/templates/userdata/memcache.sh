#!/bin/bash
sudo amazon-linux-extras install epel -y
sudo yum install memcached -y
sudo systemctl start memcached
sudo systemctl enable memcached
sudo systemctl status memcached
sudo memcached -p 11211 -U 11111 -u memcached -d

# dns
HOSTED_ZONE_ID=${hosted_zone_id}

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

DOMAIN_NAME=$(aws route53 get-hosted-zone --id "${HOSTED_ZONE_ID}" --query 'HostedZone.Name' --output text | sed 's/.$//')
aws route53 change-resource-record-sets --hosted-zone-id "${HOSTED_ZONE_ID}" --change-batch '{"Changes": [{"Action": "UPSERT","ResourceRecordSet": {"Name": "'mc01.vprofile.in'","Type": "A","TTL": 60,"ResourceRecords": [{"Value": "'"${PRIVATE_IP}"'"}]}}]}'
