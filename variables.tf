variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Cluster_kloia"
  default     = "demo-eks-cluster"
}

variable "node_group_name" {
  description = "Nama Node Group"
  default     = "demo-node-group"
}

variable "ami_id" {
  description = "ID AMI untuk worker nodes"
  default     = "ami-078748e0dc55b5fcf" # Amazon Linux 2 EKS Optimized AMI
}

variable "key_name" {
  description = "SSH Key Pair Name di AWS"
  default     = "eks-keypair"
}

variable "my_public_ips" {
  description = "List of public IP addresses for your personal devices"
  type        = list(string)
  default     = ["139.195.239.195", "111.68.26.184/29", "202.65.119.24/29"] # change with ypur ip public
}