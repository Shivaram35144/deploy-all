variable "bucket_name" {}

resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  
  tags ={
    Desc = "s3 bucket provision"
  }
}

