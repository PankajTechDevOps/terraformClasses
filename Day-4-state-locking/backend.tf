terraform {
  backend "s3" {
    bucket = "terraform-bucket-state-file-storage-3592"
    key    = "Day-2/terraform.tfstate"
    region = "us-east-1"
  }
}
