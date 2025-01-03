
variable "subnet" {
  type = string
}

variable "sg_id" {
  type = string
}

resource "aws_instance" "ec2-datadog" {
  ami           = "ami-015f3596bb2ef1aaa" # Replace with your AMI ID
  instance_type = "t2.micro"              # Free tier eligible instance type

  key_name  = aws_key_pair.ec2_poc.key_name
  subnet_id = var.subnet # Pass the subnet ID variable

  # Use VPC Security Group IDs
  vpc_security_group_ids = [var.sg_id] # Ensure var.sg_id contains a valid SG ID
}

resource "aws_key_pair" "ec2_poc" {
  key_name   = "ec2-poc"
  public_key = file("~/.ssh/ec2_poc/id_rsa.pub") # Path to your SSH public key
}

output "public_ip" {
  value = aws_instance.ec2-datadog.public_ip
}