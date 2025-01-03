# private subnet 01
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.k8s-vpc.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name                              = "private-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

# private subnet 02
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.k8s-vpc.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name                              = "private-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

# public subnet 01
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.k8s-vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-subnet-1"
    "kubernetes.io/role/elb"     = "1" #this instruct the kubernetes to create public load balancer in these subnets
    "kubernetes.io/cluster/demo" = "owned"
  }
}

# public subnet 01
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.k8s-vpc.id
  cidr_block              = "192.168.4.0/24"
  availability_zone       = "sa-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-subnet-2"
    "kubernetes.io/role/elb"     = "1" #this instruct the kubernetes to create public load balancer in these subnets
    "kubernetes.io/cluster/demo" = "owned"
  }
}
