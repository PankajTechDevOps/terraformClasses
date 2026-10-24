resource "aws_db_instance" "primary" {
    allocated_storage    = 10
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    identifier           = "pk-db-instance"
    username             = "admin"
    password             = "Cloud123"             #self managed password
    #managed_master_user_password = true  #enable password management by AWS Secrets Manager
    db_subnet_group_name = aws_db_subnet_group.sub-grp.id
    #vpc_security_group_ids = [aws_security_group.my_security_group.id]
    #publicly_accessible  = true
    skip_final_snapshot  = true
    maintenance_window    = "Sun:00:00-Sun:03:00"
    #backup_retention_period = 7
    deletion_protection = false
    #Enable CloudWatch Enhanced monitoring
    monitoring_interval = 60
    monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn
}


resource "aws_db_subnet_group" "sub-grp" {
  name = "mycustsubnet"
  subnet_ids = ["subnet-0f1420156ede2fb63","subnet-0f9e58849139689d5"]
  tags = {
    Name ="My DB Subnet group"
  }
}

  

################################################################################
# Create an IAM role to allow enhanced monitoring
################################################################################

resource "aws_iam_role" "rds_enhanced_monitoring" {
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
