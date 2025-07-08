variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "cluster_name" {
  description = "name cluster for tagging"
  type        = string
}

variable "my_public_ips" {
  description = "List of public IP addresses for your personal devices"
  type        = list(string)
  default     = ["139.195.239.195/32", "111.68.26.184/29", "202.65.119.24/29"] # change with ypur ip public
}