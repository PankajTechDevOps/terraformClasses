resource "aws_instance" "name" {
  ami =  var.ami_id                           # "ami-0d27e0fb3bac4d724"
  instance_type = var.type                    # "t3.micro"
  tags = {
    Name = "dev_Server"
  }
}
