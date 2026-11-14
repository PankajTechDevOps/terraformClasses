
# Creating VPC
resource "aws_vpc" "three-tier" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "3-tier-vpc"
  }
}

# Public Subnet 1 - Frontend Load Balancer
resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = "172.20.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-1a"
  }
}

# Public Subnet 2 - Frontend Load Balancer
resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = "172.20.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-2b"
  }
}


# Private Subnet 1 - Frontend Server
resource "aws_subnet" "prvt3" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prvt-3a"
  }
}

# Private Subnet 2 - Frontend Server
resource "aws_subnet" "prvt4" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prvt-4b"
  }
}


# Backend Server - Private Subnet 1
resource "aws_subnet" "prvt5" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prvt-5a"
  }
}

# Backend Server - Private Subnet 2
resource "aws_subnet" "prvt6" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prvt-6b"
  }
}

# RDS - Private Subnet
resource "aws_subnet" "prvt7" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.7.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prvt-7a"
  }
}


# RDS - Private Subnet 2
resource "aws_subnet" "prvt8" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = "172.20.8.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prvt-8b"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "three-tier-ig" {
  vpc_id = aws_vpc.three-tier.id

  tags = {
    Name = "3-tier-ig"
  }
}


# Creating Public Route Table
resource "aws_route_table" "three-tier-pub-rt" {
  vpc_id = aws_vpc.three-tier.id

  tags = {
    Name = "3-tier-pub-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier-ig.id
  }
}

# Attaching pub-1a subnet to Public Route Table
resource "aws_route_table_association" "public-1a" {
  route_table_id = aws_route_table.three-tier-pub-rt.id
  subnet_id      = aws_subnet.pub1.id
}

# Attaching pub-2b subnet to Public Route Table
resource "aws_route_table_association" "public-2b" {
  route_table_id = aws_route_table.three-tier-pub-rt.id
  subnet_id      = aws_subnet.pub2.id
}


# Creating Elastic IP for NAT Gateway
resource "aws_eip" "eip" {
  domain = "vpc"
}

# Creating NAT Gateway
resource "aws_nat_gateway" "cust-nat" {
  subnet_id         = aws_subnet.pub1.id
  connectivity_type = "public"
  allocation_id     = aws_eip.eip.id

  tags = {
    Name = "3-tier-nat"
  }
}


# Creating Private Route Table
resource "aws_route_table" "three-tier-prvt-rt" {
  vpc_id = aws_vpc.three-tier.id

  tags = {
    Name = "3-tier-prvt-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.cust-nat.id
  }
}

# Application private subnet associations
#  attaching prvt-3a subnet to private route table 
resource "aws_route_table_association" "private-3a" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt3.id
}

#  attaching prvt-4b subnet to private route table 
resource "aws_route_table_association" "private-4b" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt4.id
}

# Backend private subnet associations
#  attaching prvt-5a subnet to private route table 
resource "aws_route_table_association" "private-5a" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt5.id
}

#  attaching prvt-6b subnet to private route table 
resource "aws_route_table_association" "private-6b" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt6.id
}

# RDS private subnet associations
#  attaching prvt-7a subnet to private route table 
resource "aws_route_table_association" "private-7a" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt7.id
}

#  attaching prvt-8b subnet to private route table 
resource "aws_route_table_association" "private-8b" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt8.id
}

