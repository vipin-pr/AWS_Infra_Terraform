variable "amazon_linux_ami" {
  default = "ami-01816d07b1128cd2d"
}

variable "vpc_id" {
  description = "The ID of the VPC where the resources will be created"
  type        = string
}


variable "vpc_zone_identifier" {
  description = "vpc_zone_identifier for autoscaling group"
}

variable "public_subnet" {
  description = "public subnet from vpc module"
}

variable "availability_zone" {
  type = list(string)
}

variable "gateway" {
 description = "internet gateway resource" 
}