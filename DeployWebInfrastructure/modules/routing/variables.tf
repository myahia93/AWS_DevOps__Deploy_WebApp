# Module Network Outputs
variable "__vpc_id" {
  type = string
}
variable "__vpc_default_rt" {
  type = string
}
variable "__snet_public_ids" {
  type = list(string)
}
variable "__igw_id" {
  type = string
}

# Module Nat Outputs
variable "__nat_eni_id" {
  type = string
}

# Webapp
variable "__webapp_name" {
  type = string
}
