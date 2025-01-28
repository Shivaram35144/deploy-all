provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source            = "./ec2inst"
  instance_name     = var.instance_name
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  ami_id            = var.ami_id
}


module "s3" {
  source      = "./s3_bucket"
  bucket_name = var.bucket_name
}

resource "local_file" "output_file" {
  filename = "${path.module}/aws_details/output.txt"
  content  = <<EOT
EC2 Instance Details:
  Instance ID: ${module.ec2.ec2-id}
  Public IP: ${module.ec2.ec2-public-ip}
  Private IP: ${module.ec2.ec2-private-ip}

S3 Bucket Details:
  Bucket Name: ${module.s3.bucket_name}

Creation Time:
  ${timestamp()}
EOT
}

resource "local_file" "inventoryForAnsible" {
  filename = "${path.module}/../ansible/inventory"
  content  = <<EOT
all:
  hosts:
    ec2-inst-1:
      ansible_host: ${module.ec2.ec2-public-ip}
      ansible_ssh_user: ec2-user
      ansible_ssh_private_key_file: key-pair-ec2
EOT
}
