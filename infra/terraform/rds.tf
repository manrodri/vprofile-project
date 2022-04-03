resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${terraform.workspace}-${local.common_tags.project_name}-rds-subnet-group"
  subnet_ids = module.vpc.public_subnets
}

resource "aws_db_instance" "rds" {
  identifier             = "${terraform.workspace}-${local.common_tags.project_name}-rds"
  allocated_storage      = var.rds_storage_size
  engine                 = var.rds_engine
  engine_version         = var.rds_version
  instance_class         = var.rds_instance_size
  multi_az               = var.rds_multi_az
  db_name                   = "db1"
  username               = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["rds_master_user"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["rds_password"]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.backend-sg.id]
  skip_final_snapshot    = true

  tags = merge(local.common_tags,{
    Name: "${terraform.workspace}-${var.rds_db_name}"
  })
}