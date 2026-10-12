resource "aws_instance" "dev" {
  ami           = "ami-0d27e0fb3bac4d724"
  instance_type = "t3.micro"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dev"
  }
}