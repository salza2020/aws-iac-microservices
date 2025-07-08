variable "cluster_name" {
  description = "Nama EKS Cluster"
  type        = string
}

variable "node_group_name" {
  description = "Nama Node Group"
  type        = string
}

variable "vpc_id" {
  description = "ID VPC tempat cluster dibuat"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet private tempat node berada"
  type        = list(string)
}

variable "sg_id" {
  description = "Security group untuk komunikasi cluster"
  type        = string
}