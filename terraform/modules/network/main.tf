# 1. إنشاء الـ VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "ivolve-vpc" }
}

# 2. إنشاء الـ Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true # عشان السيرفر ياخد IP خارجي
  availability_zone       = "us-east-1a"
  tags = { Name = "ivolve-public-subnet" }
}

# 3. إنشاء الـ Internet Gateway (عشان السيرفر يشوف النت)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "ivolve-igw" }
}

# 4. إنشاء الـ Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "ivolve-public-rt" }
}

# 5. ربط الـ Route Table بالـ Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
