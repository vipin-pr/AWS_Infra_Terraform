
resource "aws_launch_template" "launch_template" {
  name_prefix     = "launch-template-${terraform.workspace}"
  image_id        = var.amazon_linux_ami
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  key_name = "cocktails"
  user_data = filebase64("${path.module}/user-data.sh")
    
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "cocktails-webserver"
    }

  }
}


resource "aws_autoscaling_group" "autoscaling_group" {
  name                  = "ec2-autoscaling-group-${terraform.workspace}"  
  # availability_zones    = var.availability_zone 
  desired_capacity      = 2
  max_size              = 4
  min_size              = 2
  health_check_type     = "EC2"
  termination_policies  = ["OldestInstance"]
  vpc_zone_identifier   = var.vpc_zone_identifier  #Private subnet from vpc module

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.aws-load-balancer-target-group.arn]
}