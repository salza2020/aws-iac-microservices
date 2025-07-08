resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

# Internet Gateway untuk NAT Gateway
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.cluster_name}-igw"
  }
}

resource "aws_subnet" "eks_public_subnet" {
  count                   = 1
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 0)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, 0)

  tags = {
    Name = "${var.cluster_name}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "eks_private_subnet" {
  count             = 2
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.cluster_name}-private-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${var.cluster_name}nateip"
  }
}

resource "aws_nat_gateway" "eks_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.eks_public_subnet[0].id

  tags = {
    Name = "${var.cluster_name}natgw"
  }
}

resource "aws_route_table" "eks_private_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.eks_nat_gw.id
  }

  tags = {
    Name = "${var.cluster_name}privatert"
  }
}
 resource "aws_route_table" "eks_public_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = "${var.cluster_name}publicrt"
  }
}

# Hubungkan route table ke public subnet
resource "aws_route_table_association" "eks_public_rta" {
  count          = length(aws_subnet.eks_public_subnet[*].id)
  subnet_id      = aws_subnet.eks_public_subnet[count.index].id
  route_table_id = aws_route_table.eks_public_rt.id
}
resource "aws_route_table_association" "eks_private_rta" {
  count          = length(aws_subnet.eks_private_subnet[*].id)
  subnet_id      = aws_subnet.eks_private_subnet[count.index].id
  route_table_id = aws_route_table.eks_private_rt.id
}

resource "aws_security_group" "eks_sg" {
  name        = "${var.cluster_name}sg"
  description = "Allow Kubernetes traffic internal only"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = [aws_vpc.eks_vpc.cidr_block] # Hanya izinkan dari dalam VPC
  }

  # Whitelist IP publik laptopmu
  dynamic "ingress" {
    for_each = var.my_public_ips
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}sg"
  }
}