# Availibility Zones
variable "__az" {
  type    = list(string)
}

variable "__webapp_name" {
  type = string
}

# Module Load Balancer Outputs
variable "__elb_sg_id" {
  type = string
}
variable "__elb_id" {
  type = string
}