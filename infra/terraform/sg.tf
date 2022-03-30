resource "aws_security_group" "webapp_http_inbound_sg" {
  name        = "demo_webapp_http_inbound"
  description = "Allow HTTP from Anywhere"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "terraform_demo_webapp_http_inbound"
  }
}

resource "aws_security_group" "webapp_ssh_inbound_sg" {
  name        = "demo_webapp_ssh_inbound"
  description = "Allow SSH from certain ranges"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "terraform_demo_webapp_ssh_inbound"
  })
}

resource "aws_security_group" "app_server_sg" {
  name        = "app server sg"
  description = "Allow connections form alb. 80 443"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      aws_security_group.webapp_http_inbound_sg.id,
      aws_security_group.webapp_https_inbound_sg.id
    ]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [
      aws_security_group.webapp_http_inbound_sg.id,
      aws_security_group.webapp_https_inbound_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "appserver_sg"
  })
}





resource "aws_security_group" "webapp_outbound_sg" {
  name        = "demo_webapp_outbound"
  description = "Allow outbound connections"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "terraform_demo_webapp_outbound"
  })
}

resource "aws_security_group" "backend_servers_sg" {
  name        = "backend_servers_sg"
  description = "Allow inbound from web tier"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "backend_servers_sg"
  }

  // allows traffic from the SG itself
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  // allow traffic for TCP 3306
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_server_sg.id]
  }

  ingress {
    from_port       = 11211
    to_port         = 11211
    protocol        = "tcp"
    security_groups = [aws_security_group.app_server_sg.id]
  }

  ingress {
    from_port       = 5672
    to_port         = 5672
    protocol        = "tcp"
    security_groups = [aws_security_group.app_server_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "webapp_https_inbound_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]

  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]

  }
}