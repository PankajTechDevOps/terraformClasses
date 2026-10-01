resource "aws_instance" "name" {
  ami = var.ami_id                            # "ami-0d27e0fb3bac4d724"
  instance_type = var.type                    # "t3.micro"
  tags = {
    Name = "Dev_Server"
  }
  
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"

}
resource "aws_subnet" "name" {  
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
}