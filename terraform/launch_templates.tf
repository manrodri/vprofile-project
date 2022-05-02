//resource "aws_launch_template" "k8s_master" {
//  name = "k8s_master-lt-${local.common_tags.project_name}"
//
//  capacity_reservation_specification {
//    capacity_reservation_preference = "open"
//  }
//
//  image_id = data.aws_ami.ubuntu.id
//
//  instance_initiated_shutdown_behavior = "terminate"
//
//  instance_type = "t3.medium"
//  key_name = var.key_name
//
//  monitoring {
//    enabled = false
//  }
//
//  network_interfaces {
//    associate_public_ip_address = true
//  }
//
//  vpc_security_group_ids = [aws_security_group.k8s_master.id]
//
//  tag_specifications {
//    resource_type = "instance"
//    tags = local.common_tags
//  }
//
//  user_data = filebase64("./templates/k8s_tools_install.sh")
//}

