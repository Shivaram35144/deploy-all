resource "aws_key_pair" "keypair" {
  key_name   = "mykeypair"
  public_key = file("${path.module}/key-pair-ec2.pub")
}
