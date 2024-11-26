terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  profile = "cloudwise"
  region = "us-east-1"
}
resource "aws_vpc" "cloudwise_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "cloudwise-vpc"
  }
  local {
    subnet_private_block  = cidsrsubnet(cidr_block, 2 , 0)
    subnet_public_block   = cidsrsubnet(cidr_block, 2 , 1)
    subnets_private  =  cidsrsubnet(local.subnet_private_block, 8, 8)
    subnets_public   =  cidsrsubnet(local.subnet_public_block, 8, 8)
  }
}
data "aws_availibility_zones" available {
  state = "available"
}
resource "aws_subnet" "subnet_private_a" {
  vpc_id = aws_vpc.main.id
  availibility_zone = data.aws_availibility_zones.available.names[0] #us-east-1a
  cidr_block = local.subnets_private[0]
  tags {
    Name = "subnet-private-${data.aws_availibility_zones.available.names[0]}"
  }
}
resource "aws_subnet" "subnet_private_b" {
  vpc_id = aws_vpc.main.id
  availibility_zone = data.aws_availibility_zones.available.names[1] #us-east-1b
  cidr_block = local.subnets_private[1]
  tags {
    Name = "subnet-private-${data.aws_availibility_zones.available.names[1]}"
  }
}
resource "aws_subnet" "public" {
    for_each = {
    for idx, az in data.aws_availibility_zones.available.names : az => local.subnets_isolated[idx] if idx < lenght(local.subnets_public)
  }
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  availibility_zone = each.key
    tags {
    Name = "subnet-public-${each.key}"
  }
}
resource "aws_route_table" "rtb_private_a" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ntg_public.id
  }
}
resource "aws_route_table" "rtb_private_b" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ntg_public.id
  }
}
resource "aws_route_association" "tra_private_a" {
  subnet_id = aws_subnet.subnet_private_a.id
  route_table_id = aws_route_table.rtb_private_a.id
}
resource "aws_route_association" "tra_private_b" {
  subnet_id = aws_subnet.subnet_private_b.id
  route_table_id = aws_route_table.rtb_private_b.id
}
resource "aws_route_table" "rtb_public" {
  for_each = aws_subnet.public
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_association" "tra_public {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.rtb_public[each.key].id
}
resource "aws_ip" "eip_egress" {
  tags = {
    Name = "EIP-NGW"
  }
}
resource "aws_nat_gateway" "ntg_public" {
  subnet_id  = aws_subnet.public[0].id
  allocation_id = aws_eip.eip_egress.id
  tags {
    Name = "NatGateway-public"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags {
    Name = "IGW-VPC-Main  "
  }
}
