resource "aws_instance" "instancef" {
  ami           = var.AMIS
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.instance.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  tags = {
    Name = "sridhar-instance"
  }
}
