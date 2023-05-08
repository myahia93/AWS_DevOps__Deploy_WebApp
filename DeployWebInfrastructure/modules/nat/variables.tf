# Personal IP
variable "__my_ip" {
  type = list(string)
}

# NAT
variable "__nat_ami" {
  type = string
}


# Module Network Outputs
variable "__vpc_id" {
  type = string
}
variable "__subnet_id" {
  type = string
}
