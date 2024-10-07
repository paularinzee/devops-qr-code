terraform {
    required_provider {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "main-vpc" {
    cidr_lock = "10.0.0.0/16"
    enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_1" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_lock = "10.0.0.0/20"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_lock = "10.0.16.0/20"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "subnet_3" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_lock = "10.0.32.0/20"
    availability_zone = "us-east-1d"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main-vpc.id

}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.main-vpc.id
    route {
        cidr_lock = "0.0.0.0/0"
        gatway_id = aws_internet_gateway.igw.id
    }

    route {
        cidr_lock = "10.0.16.0/16"
        gatway_id = "local"
    }

}

resource "aws_route_table_association" "subnet_1_association" {
    subnet_id = aws_subnet.subnet_1.id
    route_table_id = rt.id

}
resource "aws_route_table_association" "subnet_2_association" {
    subnet_id = aws_subnet.subnet_2.id
    route_table_id = rt.id

}
resource "aws_route_table_association" "subnet_3_association" {
    subnet_id = aws_subnet.subnet_3.id
    route_table_id = rt.id

}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster-eks"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id                   = aws_vpc.main-vpc.id
  subnet_ids               = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]
  control_plane_subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]

  eks_managed_node_groups = {
    green = {
      min_size       = 1
      max_size       = 1
      desired_size   = 1
      instance_types = ["t3.medium"]
    }
  }
}


 