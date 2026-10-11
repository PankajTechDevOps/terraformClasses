resource "aws_instance" "dev" {
  ami           = "ami-0d27e0fb3bac4d724"
  instance_type = "t3.micro"
  tags = {
    Name = "dev"
  }

#   lifecycle {
#     create_before_destroy = true
#   }

  # lifecycle {
  #   prevent_destroy = true
  # }
#   lifecycle {
#     ignore_changes = [tags, ]
#   }

}











