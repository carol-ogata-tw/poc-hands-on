resource "aws_internet_gateway" "k8s-igw" {
  vpc_id = aws_vpc.lab-vpc.id

  tags = {
    Name = "k8s-igw"
  }
}