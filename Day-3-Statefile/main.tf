resource "aws_instance" "name" {                       
  instance_type = var.type                              # "t3.micro"
    ami = var.ami_id                                    # "ami-0d27e0fb3bac4d724"
  tags = {
    Name = "Dev_Server"
  }
  
}


resource "aws_s3_bucket" "name" {
  bucket = "terraform-my-bucket-3592"
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"

}
