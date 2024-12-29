# need to edit security_groups
resource "aws_security_group" "ec2-sg" {
  name = "ec2-sg-${terraform.workspace}"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.load-balancer-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "load-balancer-sg" {
  name = "load-balancer-security-group-${terraform.workspace}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_lb_target_group" "aws-load-balancer" {
  name     = "aws-load-balancer-${terraform.workspace}"
  port     = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id 
}

resource "aws_launch_configuration" "launch-configuration" {
  name_prefix     = "launch-configuration-${terraform.workspace}"
  image_id        = var.ubuntu-ami
  instance_type   = "t2.micro"
  user_data       = file("${path.module}/user-data.sh")
  security_groups = [aws_security_group.ec2-sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ec2-as-group" {
  min_size             = 2
  max_size             = 5
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.launch-configuration.name
}