export NAME=vprofile.manuelrodriguez.cloud
export KOPS_STATE_STORE=s3://vprofile-kops-manrodri
kops delete cluster ${NAME} --yes
