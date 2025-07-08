output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.eks_private_subnet[*].id
}

output "eks_sg_id" {
  value = aws_security_group.eks_sg.id
}