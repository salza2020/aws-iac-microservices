variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block untuk VPC"
  type        = string
}

variable "cluster_name" {
  description = "Nama cluster untuk tagging"
  type        = string
}