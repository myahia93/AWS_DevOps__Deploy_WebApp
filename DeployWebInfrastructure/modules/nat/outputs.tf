output "nat_eni" {
  description = "The vpc id"
  value       = aws_instance.nat.primary_network_interface_id
}
