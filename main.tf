# --- Modul VPC ---
module "eks_vpc" {
  source = "./modules/vpc"

  region       = var.region
  vpc_cidr     = var.vpc_cidr
  cluster_name = var.cluster_name
}

# --- Modul EKS Cluster ---
module "eks_cluster" {
  source          = "./modules/eks-cluster"
  cluster_name    = var.cluster_name
  vpc_id          = module.eks_vpc.vpc_id
  subnet_ids      = module.eks_vpc.private_subnet_ids
  sg_id           = module.eks_vpc.eks_sg_id
  node_group_name = var.node_group_name
}
data "aws_ssm_parameter" "eks_ami" {
  name   = "/aws/service/eks/optimized-ami/1.29/amazon-linux-2/recommended/image_id"
  region = "us-east-1"
}
# --- Modul EKS Node Group ---
module "eks_node_group" {
  source           = "./modules/eks-node-group"
  sg_id            = module.eks_vpc.eks_sg_id
  cluster_name     = module.eks_cluster.cluster_name
  cluster_endpoint = module.eks_cluster.cluster_endpoint
  node_group_name  = var.node_group_name
  node_role_arn    = module.eks_cluster.node_role_arn
  subnet_ids       = module.eks_vpc.private_subnet_ids
  key_name         = var.key_name
  ami_id           = data.aws_ssm_parameter.eks_ami.value
}