variable "vpc-cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
  type        = string
}

variable "public-subnet-1-cidr" {
  default     = "10.0.0.0/24"
  description = "Public Subnet 1 CIDR Block"
  type        = string
}

variable "public-subnet-2-cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet 2 CIDR Block"
  type        = string
}

variable "private-subnet-1-cidr" {
  default     = "10.0.2.0/24"
  description = "Private Subnet 1 CIDR Block"
  type        = string
}

variable "private-subnet-2-cidr" {
  default     = "10.0.3.0/24"
  description = "Private Subnet 2 CIDR Block"
  type        = string
}

variable "private-subnet-3-cidr" {
  default     = "10.0.4.0/24"
  description = "Private Subnet 3 CIDR Block"
  type        = string
}

variable "private-subnet-4-cidr" {
  default     = "10.0.5.0/24"
  description = "Private Subnet 4 CIDR Block"
  type        = string
}

variable "ssh-location" {
  default     = "0.0.0.0/0"
  description = "IP Address That Can SSH Into The EC2 Instance"
  type        = string
}

variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b"]
  type    = list(string)
}

variable "lets-chat-ecr-repo" {
  default = "mighty-real-lets-chat"
  type    = string
}

variable "region" {
  default = "us-west-2"
  type    = string
}

variable "lambda_log_level" {
  default = "INFO"
  type    = string
}

variable "env" {
  default = "dev"
  type    = string
}

variable "lets-chat-lambda-timeout" {
  default = 60
  type    = number
}

variable "aws_tags" {
  default = {
    BusinessApplicationNumber = "Foo"
    ApplicationServiceNumber  = "Bar"
    Application               = "MightyReal"
  }
  type = map(string)
}

variable "debug" {
  default = true
  type    = bool
}

variable "cidr_exception" {
  type    = list(string)
  default = ["172.16.0.0/12", "192.168.0.0/16", "10.0.0.0/8"]
}

variable "elb_account_id" {
  default = "797873946194"
  type    = string
}