variable "cluster_name" {
  description = "Name EKS Cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name Node Group"
  type        = string
}

variable "vpc_id" {
  description = "ID VPC place cluster make it"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet private place node"
  type        = list(string)
}

variable "sg_id" {
  description = "Security group for communication cluster"
  type        = string
}