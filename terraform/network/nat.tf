resource "aws_eip" "k8s-eip" {
  tags = {
    Name = "k8s-eip"
  }
}

resource "aws_nat_gateway" "k8s-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-east-1a.id # need to place it in the public subnet

  tags = {
    Name = "k8s-nat"
  }

  depends_on = [aws_internet_gateway.k8s-igw]
}