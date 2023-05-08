variable "associate_public_ip_address" {
 type = string
 default = "true"
}
variable "base_ami" {
 type = string
 default = "ami-006e00d6ac75d2ebb"
}
variable "instance_type" {
 type = string
 default = "t3.micro"
}
variable "region" {
 type = string
 default = "us-east-1"
}
variable "app_name" {
 type = string
}
variable "ssh_username" {
 type = string
 default = "ubuntu"
}

locals {
 timestamp = formatdate("DD_MM_YYYY-hh_mm", timestamp())
}

source "amazon-ebs" "static-web-ami" {
 ami_name = "${var.app_name}-${local.timestamp}"
 associate_public_ip_address = "${var.associate_public_ip_address}"
 instance_type = "${var.instance_type}"
 region = "${var.region}"
 source_ami = "${var.base_ami}"
 ssh_username = "${var.ssh_username}"
 iam_instance_profile = "LabInstanceProfile"
 tags = {
 Name = "${var.app_name}"
 }
}

build {
 sources = ["source.amazon-ebs.static-web-ami"]
 provisioner "ansible" {
 playbook_file = "./playbook/webapp.yml"
 use_proxy = false
 }
}