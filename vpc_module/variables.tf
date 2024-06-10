variable  "aws_region" {
    type        = string
    default     = "us-east-1"
    description = "AWS region for these resources"
}

variable "prefix" {
  type        = string
  default     = "tocoder"
  description = "Project prefix"
}

 variable "vpc_cidr" {
   type        = string
   default     = "10.0.0.0/16"
   description = "VPC cidr range"
 }
    
variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24","10.0.2.0/24"]
  description = "Public subnet range"
}

variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.3.0/24","10.0.4.0/24"]
  description = "Private subnet range"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a","us-east-1b"]
  description = "availability zones for the public subnets"
}
