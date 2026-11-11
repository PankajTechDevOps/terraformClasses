
# Create AWS Key Pair
resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# Create EC2 Instance
resource "aws_instance" "server" {
  ami           = "ami-0d27e0fb3bac4d724" # Ubuntu AMI
  instance_type = "t3.micro"
  key_name      = aws_key_pair.example.key_name
}
