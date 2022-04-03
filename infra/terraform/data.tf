data "aws_availability_zones" "available" {}

########
# DNS
#######
data "aws_route53_zone" "public" {
  name         = var.public_hosted_zone
  private_zone = false

}



#######################
# compute
#######################

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



data "template_file" "userdata" {
  template = file("templates/userdata.sh")

  vars = {
    //    wp_db_hostname      = aws_db_instance.rds.endpoint
    //    wp_db_name          = "${terraform.workspace}${local.rds_db_name}"
    //    wp_db_user          = var.rds_username
    //    wp_db_password      = var.rds_password
    //    playbook_repository = var.playbook_repository
    greeting = "Hello world"
  }
}

data "aws_acm_certificate" "my_cert" {
  provider = aws.cert
  domain   = var.public_hosted_zone
}

data "aws_secretsmanager_secret" "by-arn" {
  arn = var.secret_arn
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.by-arn.id
}