variable "ubuntu-ami" {
  default = "ami-0e2c8caa4b6378d8c"
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