resource "aws_launch_configuration" "launch-configuration" {
  name_prefix     = "launch-configuration-${terraform.workspace}"
  image_id        = var.amazon_linux_ami
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
  availability_zones = var.availability_zone 
}


resource "aws_autoscaling_attachment" "aws_as_attachment" {
  autoscaling_group_name = aws_autoscaling_group.ec2-as-group.id
  lb_target_group_arn    = aws_lb_target_group.aws-load-balancer-target-group.id
}

