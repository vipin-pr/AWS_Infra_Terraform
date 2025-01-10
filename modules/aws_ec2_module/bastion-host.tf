resource "aws_instance" "bastion-host" {
  ami           = var.amazon_linux_ami
  instance_type = "t2.micro"
  subnet_id = var.public_subnet.id
  key_name = "cocktails"

  tags = {
    Name = "bastion-host"
  }
}