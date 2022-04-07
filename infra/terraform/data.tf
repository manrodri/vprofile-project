data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_key_pair" "example" {
  key_name = "test-key"

}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu*18.04-amd64-server*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}


data "aws_ami" "centos" {
  filter {
    name = "name"
    values = ["CentOS-7*"]
  }
  owners = ["423754860743"]
}



data "template_file" "jenkins" {
  template = file("./templates/jenkins-setup.sh")
  vars = {
    foo = "bar"
  }
}