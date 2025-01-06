

# resource "aws_autoscaling_group" "ec2-as-group" {
#   min_size             = 2
#   max_size             = 5
#   desired_capacity     = 2
#   launch_configuration = aws_launch_configuration.launch-configuration.name
#   availability_zones = var.availability_zone 
# }


# resource "aws_autoscaling_attachment" "aws_as_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.ec2-as-group.id
#   lb_target_group_arn    = aws_lb_target_group.aws-load-balancer-target-group.id
# }

resource "aws_launch_template" "launch_template" {
  name_prefix     = "launch-template-${terraform.workspace}"
  image_id        = var.amazon_linux_ami
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                  = "ec2-autoscaling-group-${terraform.workspace}"  
  availability_zones    = var.availability_zone 
  desired_capacity      = 2
  max_size              = 4
  min_size              = 2
  health_check_type     = "EC2"
  termination_policies  = ["OldestInstance"]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.aws-load-balancer-target-group.arn]
}