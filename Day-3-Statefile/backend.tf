terraform {
  backend "s3" {
    bucket = "terraform-my-bucket-3592"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}


# This block is for state file