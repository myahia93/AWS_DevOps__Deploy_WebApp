output "sg_id" {
  value = aws_security_group.sg-elb.id
}

output "elb_id" {
  value = aws_elb.elb.id
}
