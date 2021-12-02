resource "aws_security_group" "starter-api-db-security-group" {
  name        = "starter-api-db-security-group"
  description = "Security group for Starter API DB subnet"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port = 5432
    protocol  = "TCP"
    to_port   = 5432
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group for Lambda and API
resource "aws_security_group" "starter_data_upserter_security_group" {
  name        = "starter-get-data"
  description = "Security group for Starter API/Lambda"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port = 0
    protocol  = "TCP"
    to_port   = 65535
    self      = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Database Subnet Group
# terraform aws db subnet group
resource "aws_db_subnet_group" "starter-api-db-subnet-group" {
  name = "database subnets"
  subnet_ids = [
    aws_subnet.private-subnet-3.id,
    aws_subnet.private-subnet-4.id
  ]
  description = "Subnets for Database Instance"

  tags = {
    Name = "Database Subnets"
  }
}
