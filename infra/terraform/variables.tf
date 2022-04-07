#################
# locals
#################

locals {
  common_tags = {
    environment  = terraform.workspace
    team         = "Cloud and Hosting"
    project_name = "vp_profile"
  }
}

#################
# variables
#################

variable "profile" {
  type = string
  default = "jenkins"
}

variable "region" {
  type = string
  default = "eu-west-1"
}


#######
# vpc
######


variable "subnet_count" {
  type = map(number)
}

variable "private_subnets" {
  type = map(list(string))
}

variable "cidr_block" {
  type = map(string)
}



variable "public_subnets" {
  type = map(list(string))
}

#########
# ec2
########

variable "private_key_path" {
  type    = string
  default = "/Users/manuelrodriguez/Desktop/aws-keys/test-key.pem"
}

variable "jenkins_instance_size" {
  type = string
  default = "t2.micro"
}

variable "centos_ami" {
  type = string
  default = "ami-05a178e6f938f2c39"
}

