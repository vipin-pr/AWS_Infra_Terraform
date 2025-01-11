resource "aws_instance" "bastion-host" {
  ami           = var.amazon_linux_ami
  instance_type = "t2.micro"
  subnet_id = var.public_subnet.id
  key_name = "cocktails"
  associate_public_ip_address = "true" 
  security_groups = [aws_security_group.bastion-host-sg.id]

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_security_group" "bastion-host-sg" {
  name = "bastion-host-${terraform.workspace}"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "bastion-host-ip" {
  value = aws_instance.bastion-host.public_ip
} 