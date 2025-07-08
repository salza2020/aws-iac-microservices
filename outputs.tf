output "vpc_id" {
  value = module.eks_vpc.vpc_id
}

output "private_subnets" {
  value = module.eks_vpc.private_subnet_ids
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "kubeconfig_command" {
  value     = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.region}"
  sensitive = true
}