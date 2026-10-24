resource "aws_db_instance" "primary" {
    allocated_storage    = 10
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    identifier           = "books-rds"
    username             = "admin"
    #password             = "Cloud123"             #self managed password
    manage_master_user_password = true #enable password management by AWS Secrets Manager
    db_subnet_group_name = aws_db_subnet_group.my_subnet_group.id    #vpc_security_group_ids = [aws_security_group.my_security_group.id]
    #publicly_accessible  = true
    skip_final_snapshot  = true
    maintenance_window    = "Sun:00:00-Sun:03:00"
    #backup_retention_period = 7
    #deletion_protection = true
    #Enable CloudWatch Enhanced monitoring
    #monitoring_interval = 60
    #monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn
    #depends_on = [ aws_db_subnet_group.my_subnet_group ]
}


resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "dev"
    }
  
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "my-igw"
    }
  
}

# resource "aws_route_table" "name" {
#     vpc_id = aws_vpc.name.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.name.id
#     }
# }

# resource "aws_route_table_association" "subnet-1" {
#     subnet_id      = aws_subnet.subnet-1.id
#     route_table_id = aws_route_table.name.id
# }

# resource "aws_route_table_association" "subnet-2" {
#     subnet_id      = aws_subnet.subnet-2.id
#     route_table_id = aws_route_table.name.id
# }


resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "my-subnet"
    }
}

resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "my-subnet"
    }
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
}

  

################################################################################
# Create an IAM role to allow enhanced monitoring
################################################################################

/*resource "aws_iam_role" "rds_enhanced_monitoring" {
  name_prefix        = "rds-enhanced-monitoring-"
  assume_role_policy = data.aws_iam_policy_document.rds_enhanced_monitoring.json
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}
*/