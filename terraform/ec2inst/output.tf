output "ec2-id"{
    value = aws_instance.inst.id
}

output "ec2-public-ip"{
    value = aws_instance.inst.public_ip
}

output "ec2-private-ip"{
    value = aws_instance.inst.private_ip
}

