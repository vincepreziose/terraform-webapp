resource "aws_security_group" "mightyreal_public_alb_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Project     = "Mighty Real Digital"
    Description = "Mighty Real Digital Public ALB Default Security Group"
  }
}

resource "aws_security_group_rule" "mightyreal_public_alb_ingress_rule" {
  type              = "ingress"
  from_port         = 443
  protocol          = "TCP"
  to_port           = 443
  cidr_blocks       = var.cidr_exception
  security_group_id = aws_security_group.mightyreal_public_alb_sg.id
}

resource "aws_security_group_rule" "mightyreal_public_alb_egress_rule" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  security_group_id = aws_security_group.mightyreal_public_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_lb" "mightyreal_public_alb" {
  name               = "mightyreal-public-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [
    aws_security_group.mightyreal_public_alb_sg.id
  ]
  subnets            = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]

  idle_timeout                     = var.alb_idle_timeout
  enable_cross_zone_load_balancing = var.alb_enable_cross_zone_load_balancing
  ip_address_type                  = var.alb_ip_address_type
  drop_invalid_header_fields       = var.alb_drop_invalid_header_fields

  access_logs {
    bucket  = aws_s3_bucket.access_logs.bucket
    prefix  = "mrd"
    enabled = true
  }

  tags = {
    Project     = "Mighty Real Digital"
    Description = "Mighty Real Digital Public ALB"
  }

  timeouts {
    create = var.alb_create_timeout
    update = var.alb_update_timeout
    delete = var.alb_delete_timeout
  }
}

resource "aws_lb_listener" "mightyreal_public_alb" {
  load_balancer_arn = aws_lb.mightyreal_public_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.public_alb.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Path does not exist."
      status_code  = "404"
    }
  }
}
