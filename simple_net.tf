resource "aws_vpc" "aws_obj" {
    count=var.is_local
    cidr_block = var.vpc_cidr
    tags = {Name=var.key_name}
    }

resource "aws_internet_gateway" "aws_obj" {
    count=var.is_local
    vpc_id = aws_vpc.aws_obj[0].id
    tags = {Name=var.key_name}
    depends_on = [aws_vpc.aws_obj]
    }
resource "aws_eip" "testEip1" {
    count=var.is_local
    vpc=true
    public_ipv4_pool="amazon"
    }
resource "aws_eip" "testEip2" {
    count=var.is_local
    vpc=true
    public_ipv4_pool="amazon"
    }
resource "aws_eip" "testEip3" {
    count=var.is_local
    vpc=true
    public_ipv4_pool="amazon"
    }

resource "aws_subnet" "awsobj1ta" {
  count=var.is_local
  vpc_id     = aws_vpc.aws_obj[0].id
  cidr_block = var.subnet1
  tags = {Name=var.key_name}
  availability_zone="us-east-1a"
}

resource "aws_subnet" "awsobj1tb" {
  count=var.is_local
  vpc_id     = aws_vpc.aws_obj[0].id
  cidr_block = var.subnet2
  tags = {Name=var.key_name}
  availability_zone="us-east-1b"
}

resource "aws_subnet" "awsobj1tc" {
  count=var.is_local
  vpc_id     = aws_vpc.aws_obj[0].id
  cidr_block = var.subnet3
  tags = {Name=var.key_name}
  availability_zone="us-east-1c"
}
####
locals {
    lsubA= var.is_local == 1 ? aws_subnet.awsobj1ta[0].id : null
    lsubB= var.is_local == 1 ? aws_subnet.awsobj1tb[0].id : null
    lsubC= var.is_local == 1 ? aws_subnet.awsobj1tc[0].id : null
    
    }
####
output "subtnet1_out" {
    value = aws_subnet.awsobj1ta[*].id
}
output "subtnet2_out" {
    value = aws_subnet.awsobj1tb[*].id
}
output "subtnet3_out" {
    value = aws_subnet.awsobj1tc[*].id
}

output "local_aws_eip3_out" {
    value = aws_eip.testEip3[*].id
}
output "local_igw_id_out" {
    value = aws_internet_gateway.aws_obj[*].id
}
output "local_vpc_out" {

    value=aws_vpc.aws_obj[*].id
}
