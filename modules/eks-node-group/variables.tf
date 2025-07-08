variable "cluster_name" {
  description = "Nama EKS Cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "Endpoint EKS Cluster"
  type        = string
}

variable "node_group_name" {
  description = "Nama Node Group"
  type        = string
}

variable "node_role_arn" {
  description = "IAM Role ARN untuk node group"
  type        = string
}

variable "subnet_ids" {
  description = "List subnet ID untuk node group"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID untuk node worker"
  type        = string
}

variable "key_name" {
  description = "SSH Key Pair Name di AWS"
  type        = string
}

variable "sg_id" {
  description = "Security group ID untuk node"
  type        = string
}