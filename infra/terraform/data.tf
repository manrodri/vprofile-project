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
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server*"]
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

data "template_file" "memcache" {
  template = file("./templates/userdata/memcache.sh")

  vars = {
    hosted_zone_id = aws_route53_zone.private.zone_id
  }
}

data "template_file" "mysql" {
  template = file("./templates/userdata/mysql.sh")

  vars = {
    hosted_zone_id = aws_route53_zone.private.zone_id
  }
}

data "template_file" "rabbitMQ" {
  template = file("./templates/userdata/rabbitMQ_amazon-linux.sh")

  vars = {
    hosted_zone_id = aws_route53_zone.private.zone_id
  }
}



