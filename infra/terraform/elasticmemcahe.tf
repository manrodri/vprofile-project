resource "aws_elasticache_cluster" "vprofile" {
  cluster_id           = "${local.common_tags.environment}-${local.common_tags.project_name}-cluster"
  engine               = "memcached"
  node_type            = var.memchace_instance_size
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  security_group_ids = [aws_security_group.backend-sg.id]
  subnet_group_name = aws_elasticache_subnet_group.vprofile.name
  port                 = 11211
  az_mode = "single-az"

  tags = merge(local.common_tags, {
    Name: "${local.common_tags.environment}-${local.common_tags.project_name}-memcached"
  })
}

resource "aws_elasticache_subnet_group" "vprofile" {
  name       = "${local.common_tags.environment}-${local.common_tags.project_name}-memcache-subnet-group"
  subnet_ids = module.vpc.public_subnets
}
