# Location
variable "region" {
  type    = string
  default = "us-east-1"
}

# VPC
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "webapp_name" {
  type = string
}

# Subnet
variable "snet_public_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "snet_private_cidr" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# Availibility Zones
variable "az" {
  type    = list(string)
  default = ["a", "b", "c"]
}

# Personal IP
variable "my_ip" {
  type    = list(string)
  default = ["***TO_BE_DEFINED***/32"]
}

# NAT
variable "nat_ami" {
  type    = string
  default = "ami-007855ac798b5175e"
}