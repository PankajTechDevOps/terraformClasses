output "PublicIP" {
  value = aws_instance.name.public_ip
}
output "PrivateIP" {
  value = aws_instance.name.private_ip
}
output "az" {
  value = aws_instance.name.availability_zone
}