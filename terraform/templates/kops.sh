export NAME=vprofile.manuelrodriguez.cloud
export KOPS_STATE_STORE=s3://vprofile-kops-manrodri
kops create cluster ${NAME} \
  --zones "eu-west-1a,eu-west-1b" \
  --node-count 3 \
  --node-size t3.micro \
  --master-size t3.small \
  --state=${KOPS_STATE_STORE} \
  --dns-zone=manuelrodriguez.cloud \

