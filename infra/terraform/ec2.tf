resource "aws_launch_configuration" "rabbitMQ" {
  lifecycle {
    create_before_destroy = true
  }

  name_prefix = "${terraform.workspace}-rabbitMQ"
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = var.asg_instance_size[terraform.workspace]
  key_name = var.key
  iam_instance_profile = aws_iam_instance_profile.asg.name

  security_groups = [
    aws_security_group.backend_servers_sg.id,
  ]

  user_data = data.template_file.rabbitMQ.rendered
  associate_public_ip_address = true

}

resource "aws_launch_configuration" "mysql" {
  lifecycle {
    create_before_destroy = true
  }

  name_prefix = "${terraform.workspace}-mysql"
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = var.asg_instance_size[terraform.workspace]
  key_name = var.key
  iam_instance_profile = aws_iam_instance_profile.asg.name

  security_groups = [
    aws_security_group.backend_servers_sg.id,
  ]

  user_data = data.template_file.mysql.rendered
  associate_public_ip_address = true

}

resource "aws_launch_configuration" "memcache" {
  lifecycle {
    create_before_destroy = true
  }

  name_prefix = "${terraform.workspace}-memcahe"
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = var.asg_instance_size[terraform.workspace]
  key_name = var.key
  iam_instance_profile = aws_iam_instance_profile.asg.name

  security_groups = [
    aws_security_group.backend_servers_sg.id,
  ]

  user_data = data.template_file.memcache.rendered
  associate_public_ip_address = true


}


resource "aws_autoscaling_group" "memcache" {
  desired_capacity = 1
  max_size = 1
  min_size = 1
  vpc_zone_identifier = module.vpc.public_subnets


  launch_configuration = aws_launch_configuration.memcache.id

  tag {
    key                 = "Name"
    value               = "memcache"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

}

resource "aws_autoscaling_group" "mysql" {
  desired_capacity = 1
  max_size = 1
  min_size = 1
  vpc_zone_identifier = module.vpc.public_subnets


  launch_configuration = aws_launch_configuration.mysql.id

  tag {
    key                 = "Name"
    value               = "mysql"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

}

resource "aws_autoscaling_group" "rabbitMQ" {
  desired_capacity = 1
  max_size = 1
  min_size = 1
  vpc_zone_identifier = module.vpc.public_subnets

  launch_configuration = aws_launch_configuration.rabbitMQ.id

  tag {
    key                 = "Name"
    value               = "rabbitMQ"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

