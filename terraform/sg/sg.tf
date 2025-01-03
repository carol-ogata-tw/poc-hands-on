variable "vpc_id" {
  type = string
}

resource "aws_security_group" "sg_ssh" {
  name_prefix = "allow-ssh"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace "0.0.0.0/0" with your IP for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "sg_id" {
  value = aws_security_group.sg_ssh.id
}