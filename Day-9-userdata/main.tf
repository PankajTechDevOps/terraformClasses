resource "aws_instance" "name" {
    instance_type = var.type
    ami = var.ami_id
    user_data = file("test.sh")   # Calling test.sh from current directory by using file function
    tags = {
        Name="Dev_Server"
    }
}
