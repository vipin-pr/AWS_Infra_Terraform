variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  default = "default"
}

variable "private_subnet_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_block" {
  default = "10.0.10.0/24"
}

variable "public_subnet_cidr_block_2" {
  default = "10.0.20.0/24"
}

variable "availability_zone" {
  default = [ "us-east-1a", "us-east-1b", "us-east=1c" ]
}


