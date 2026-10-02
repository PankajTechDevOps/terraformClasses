variable "ami_id" {
  description = "passing ami value"
  default = "ami-0d27e0fb3bac4d724"
  type = string

}
variable "type" {
  description = "passing values to instance type"
  default = "t3.micro"
  type = string

}