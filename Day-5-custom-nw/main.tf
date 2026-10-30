# Create vpc
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "cust-vpc"
  }
}

# Create subnet
resource "aws_subnet" "name" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "cust-subnet-1-public"
  }

}

resource "aws_subnet" "name-2" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "cust-subnet-2-private"
  }

}

# Create IG and attached to vpc

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "cust-igw"
  }

}

# Create Routetable and Edit routes

resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id

  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id

  }
  tags = {
    Name = "cust-rt"
  }

}

# Create Subnet association

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.name.id
  route_table_id = aws_route_table.name.id

} 

# Create SG

resource "aws_security_group" "name" {
  name        = "cust-sg"
  description = "allow"
  vpc_id      = aws_vpc.name.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create servers

resource "aws_instance" "public" {
  ami                         = "ami-0d27e0fb3bac4d724" #Amazon 2023 linux
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.name.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  associate_public_ip_address = true
  tags = {
    Name = "public-ec2"
  }

}


resource "aws_instance" "pvt" {
  ami                         = "ami-0d27e0fb3bac4d724" #Amazon 2023 linux
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.name-2.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  tags = {
    Name = "pvt-ec2"
  }

}
