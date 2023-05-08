# Availibility Zones
variable "az" {
  type    = list(string)
  default = ["a", "b", "c"]
}

variable "webapp_name" {
  type = string
}
