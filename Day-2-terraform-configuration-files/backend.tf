terraform {
  backend "s3" {
    bucket = "terraform-my-bucket-3592"
    key    = "Day-2/terraform.tfstate"
    region = "us-east-1"
  }
}
