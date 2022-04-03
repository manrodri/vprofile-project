variable "profile" {
  type    = string
  default = "jenkins"
}
variable "region" {
  type    = string
  default = "eu-west-1"
}

// networking
variable "cidr_block" {
  type = map(string)
}

variable "subnet_count" {
  type = map(number)
}

variable "private_subnets" {
  type = map(list(string))
}

variable "public_subnets" {
  type = map(list(string))
}

locals {
  common_tags = {
    environment  = terraform.workspace
    team         = "Cloud and Hosting"
    project_name = "vprofile-java-webapp"
  }

}


######
# dns
######
variable "public_hosted_zone" {
  type = string
  default = "manuelrodriguez.cloud"

}

variable "demo_dns_name" {
  type = string
  default = "myapp"
}



####
# compute
####

variable "ip_range" {
  default = "0.0.0.0/0"
}

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

####
# db
####

variable "rds_storage_size" {
  type = number
}

variable "rds_engine" {
  type = string
}

variable "rds_version" {
  type = string
}

variable "rds_instance_size" {
  type = string
}

variable "rds_multi_az" {
  type = bool
}

variable "rds_db_name" {
  type = string
}


###
# secret manager
####

variable "secret_arn" {
  type = string
  default = "arn:aws:secretsmanager:eu-west-1:423754860743:secret:remoteRepositorieKeys-YCaGMz"
}


####
# memcache
#####

variable "memchace_instance_size" {
  type = string
  default = "cache.t3.micro"
}


####
# mq
####

variable "mq_password" {
  type = string
}
