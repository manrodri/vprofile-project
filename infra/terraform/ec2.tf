resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.jenkins_instance_size
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.jenkins.name
  key_name = data.aws_key_pair.example.key_name

  security_groups = [aws_security_group.jenkins.id]
  user_data = file("./templates/jenkins-setup.sh")


  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "nexus" {
  ami           = var.centos_ami
  instance_type = var.jenkins_instance_size
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.jenkins.name
  key_name = data.aws_key_pair.example.key_name

  security_groups = [aws_security_group.nexus.id]
  user_data = file("./templates/nexus-setup.sh")


  tags = {
    Name = "Nexus"
  }
}