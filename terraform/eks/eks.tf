# IAM role for eks
resource "aws_iam_role" "eks-role" {
  name = "eks-cluster-role"
  tags = {
    tag-key = "eks-cluster-role"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# eks policy attachment
resource "aws_iam_role_policy_attachment" "eks-policy-attach" {
  role       = aws_iam_role.eks-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS
resource "aws_eks_cluster" "demo-eks" {
  name     = "demo-eks"
  role_arn = aws_iam_role.eks-role.arn

  vpc_config {
    subnet_ids = [
      var.private-subnet-1-id,
      var.private-subnet-2-id,
      var.public-subnet-1-id,
      var.public-subnet-2-id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks-policy-attach]
}