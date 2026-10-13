resource "aws_instance" "name" {
  ami = "ami-097855b862d5b1eb2"
  instance_type = "t3.small"
  tags = {
    Name = "Test-Ec2"
  }
 }