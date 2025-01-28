variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  default     = "deploy-all"
}

variable "availability_zone" {
  description = "Availability zone for the EC2 instance"
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0ac4dfaf1c5c0cce9"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "deploy-all-35144"
}

