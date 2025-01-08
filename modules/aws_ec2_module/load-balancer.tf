resource "aws_lb" "load-balancer" {
  name               = "load-balancer-${terraform.workspace}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load-balancer-sg.id]
  subnets = [var.public_subnet.id, var.public_subnet_2.id]
  depends_on = [ var.gateway ]
}

resource "aws_lb_target_group" "aws-load-balancer-target-group" {
  name     = "aws-load-balancer-tg-${terraform.workspace}"
  port     = 8080 
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "aws_lb_listener" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws-load-balancer-target-group.arn
  }
}