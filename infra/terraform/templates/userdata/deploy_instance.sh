sudo yum install -y java-1.8.0-openjdk
cd /tmp
sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.8.5 /opt/maven
echo  "export PATH=/opt/maven/bin:$PATH" | sudo tee ~/.bash_profile
. ~/.bash_profile

# get the source code

cd && sudo yum install -y git
git clone https://github.com/manrodri/vprofile-project.git && cd vprofile-project && git checkout aws-LiftAndShift


# build artifact
echo foo > /tmp/vprofile.war
ARTIFACT_PATH='/tmp/vprofile.war'
S3_BUCKET_NAME=${s3_bucket_name}

aws s3 cp  $ARTIFACT_PATH s3://$S3_BUCKET_NAME