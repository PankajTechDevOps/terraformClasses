
# RDS Password
variable "rds-password" {
  description = "rds password"
  type        = string
  sensitive   = true
  default     = "Admin#12345"
}

# RDS Username
variable "rds-username" {
  description = "rds username"
  type        = string
  default     = "admin"
}

# AMI ID
variable "ami" {
  description = "ami"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}

# EC2 Instance Type
variable "instance-type" {
  description = "instance-type"
  type        = string
  default     = "t3.micro"
}

# Key Name
variable "key-name" {
  description = "keyname"
  type        = string
  default     = "us-east-1"
}


# RDS Backup Retention Period
variable "backup-retention" {
  type    = number
  default = 7
}
