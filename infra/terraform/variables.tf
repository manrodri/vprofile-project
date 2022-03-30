##########
# LOCALS
#########

locals {
  only_in_acg_mapping = {
    dev = 0
    acg = 1
  }
  common_tags = {
    environment  = terraform.workspace
    team         = "Cloud and Hosting"
    project_name = "vp_profile"
  }

  only_in_acg = local.only_in_acg_mapping[terraform.workspace]
}

########
# vpc
#######

variable "subnet_count" {
  type = map(number)
}


variable "private_subnets" {
  type = map(list(string))
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "key_name" {
  type    = string
  default = "test-key"
}

variable "cidr_block" {
  type = map(string)
}


variable "private_key_path" {
  type    = string
  default = "/Users/manuelrodriguez/Desktop/aws-keys/test-key.pem"
}
variable "domain_name" {
  default = "manuelrodriguez.cloud"
}

variable "public_subnets" {
  type = map(list(string))
}


#####
# asg
#####


variable "asg_instance_size" {
  type = map(string)
}

variable "asg_max_size" {
  type = map(number)
}
variable "asg_min_size" {
  type = map(number)
}

variable "key" {
  type = string
}
