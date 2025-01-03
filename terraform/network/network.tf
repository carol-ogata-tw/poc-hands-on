# Data Source: Default VPC
data "aws_vpc" "default" {
  default = true
}

# Data Source: Default Internet Gateway
data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Create a Public Subnet in the Default VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.1.0/24" # Replace with an available CIDR block in your default VPC
  map_public_ip_on_launch = true
  availability_zone       = "sa-east-1a" # Replace with your preferred AZ
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}