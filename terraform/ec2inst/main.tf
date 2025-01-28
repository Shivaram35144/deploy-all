variable "ami_id" {}
variable "instance_type" {}
variable "instance_name" {}
variable "availability_zone" {}

resource "aws_instance" "inst"{
    instance_type = var.instance_type
    ami = var.ami_id
    key_name = aws_key_pair.keypair.key_name
    vpc_security_group_ids = [aws_security_group.ec2.id]
    tags = {
        Desc = "Terraform EC2 instance"
    }
    
}