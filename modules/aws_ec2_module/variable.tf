variable "ubuntu-ami" {
  default = "ami-0e2c8caa4b6378d8c"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "vpc_zone_identifier" {
  description = "vpc_zone_identifier for autoscaling group"
}

variable "public_subnet" {
 description = "public subnet from vpc module" 
}