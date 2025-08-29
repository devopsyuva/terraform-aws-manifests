output "vpc_name" {
  value = aws_vpc.vpc_demo.id
  description = "VPC ID"
}

output "vpc_cidr" {
  value = aws_vpc.vpc_demo.cidr_block
  description = "VPC CIDR range"
}