# Output for vpc.id

output "vpc_id" {
  value = aws_vpc.vpc.id
}

# Output for vpc_zone_identifiers

output "vpc_zone_identifier_id" {
  value = [aws_subnet.public_subnet]
}

output "public_subnet" {
 value = aws_subnet.public_subnet 
}