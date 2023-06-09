#VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc"
  }
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}
#SUBNETS

data "aws_availability_zones" "available_az" {}

resource "aws_subnet" "public_subnet1" {

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[0]
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[1]
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "private_subnet1" {

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet3_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[0]
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet4_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[1]
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "private_subnet2"
  }
}

#ROUTE TABLES
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_instance" "instance1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  user_data              = file("apache.sh")
  subnet_id              = aws_subnet.public_subnet1.id
  

  tags = {
    Name = "instance webtier1"
  }
}

resource "aws_instance" "instance2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  user_data              = file("apache.sh")
  subnet_id              = aws_subnet.public_subnet2.id

  tags = {
    Name = "instance webtier2"
  }
}