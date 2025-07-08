#!/bin/bash
set -o xtrace
sudo yum install -y amazon-efs-utils chrony jq
sudo systemctl enable chronyd
sudo systemctl start chronyd
echo "EKS_CLUSTER_NAME=${cluster_name}" >> /etc/environment