output "jenkins_connect" {
  value = "ssh -i ${data.aws_key_pair.example.key_name}.pem ubuntu@${aws_instance.jenkins.public_dns}"
}

output "centos_images" {
  value = [data.aws_ami.centos]
}