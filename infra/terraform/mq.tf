module "rabbitmq" {
  source = "mhmdio/rabbitmq/aws"
  version = "0.1.0"

  broker_name = "${local.common_tags.environment}-vprofile-mq"
  host_instance_type = "mq.t3.micro"
  password = var.mq_password
  security_groups = [
    aws_security_group.backend-sg.id]
  subnet_ids = [
    module.vpc.public_subnets[0]]
  username = "rabbit"

}