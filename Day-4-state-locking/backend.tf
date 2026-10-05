terraform {
  backend "s3" {
    bucket = "terraform-bucket-state-file-storage-3592"
    key    = "Day-2/terraform.tfstate"
  # use_lockfile = true           # to use S3 native locking
    region = "us-east-1"
    dynamodb_table = "veera"      # any version we can use dynamoDB
    encrypt = true
    
  }
}
