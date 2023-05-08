# Location
variable "__region" {
  type = string
}

# VPC
variable "__vpc_cidr" {
  type = string
}
variable "__webapp_name" {
  type = string
}

# Subnet
variable "__snet_public_cidr" {
  type = list(string)
}
variable "__snet_private_cidr" {
  type = list(string)
}

# Availibility Zones
variable "__az" {
  type = list(string)
}
