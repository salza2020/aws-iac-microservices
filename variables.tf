variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Nama EKS Cluster"
  default     = "private-eks-cluster"
}

variable "node_group_name" {
  description = "Nama Node Group"
  default     = "private-node-group"
}

variable "ami_id" {
  description = "ID AMI untuk worker nodes"
  default     = "ami-078748e0dc55b5fcf" # Amazon Linux 2 EKS Optimized AMI
}

variable "key_name" {
  description = "SSH Key Pair Name di AWS"
  default     = "eks-keypair"
}