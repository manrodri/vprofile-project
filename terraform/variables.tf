##########
# LOCALS
#########

locals {
  common_tags = {
    environment  = terraform.workspace
    team         = "Cloud and Hosting"
    project_name = "vp_profile_k8s"
  }
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