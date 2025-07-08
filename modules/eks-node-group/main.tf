data "aws_ssm_parameter" "eks_ami" {
  name   = "/aws/service/eks/optimized-ami/1.29/amazon-linux-2/recommended/image_id"
  region = "us-east-1" # ganti sesuai kebutuhan
}

resource "aws_launch_template" "eks_node_lt" {
  name          = "${var.node_group_name}"
  image_id = var.ami_id != "" ? var.ami_id : data.aws_ssm_parameter.eks_ami.value
  instance_type = "t3.medium"
  key_name      = var.key_name

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.node_group_name}"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.sg_id]
  }

  user_data = base64encode(templatefile("${path.module}/../../userdata.tpl", {
    cluster_name = var.cluster_name
  }))
}


resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  launch_template {
    id      = aws_launch_template.eks_node_lt.id
    version = "$Default"
  }

}