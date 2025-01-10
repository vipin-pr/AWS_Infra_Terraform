output "dns_name_lb" {
  value = aws_lb.load-balancer.dns_name
}

output "bastion-host-ip" {
  value = aws_instance.bastion-host.public_ip
} 