resource "aws_lb" "mighty-real-public-alb" {
  name               = "mighty-real-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.might-real-wide-open-sg.id]
  subnets = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.mighty-real-public-alb-access-logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}