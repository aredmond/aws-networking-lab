# IAM Role
resource "aws_iam_role" "instance_role" {
  name = "${var.instance_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# IAM Policy
resource "aws_iam_policy" "instance_policy" {
  name        = "${var.instance_name}-policy"
  description = "Policy for ${var.instance_name} instance"
  policy      = file("${path.module}/iam/bastion_policy.json")
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "instance_policy_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.instance_policy.arn
}

# Instance Profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.instance_name}-profile"
  role = aws_iam_role.instance_role.name
}

# Security Group
resource "aws_security_group" "instance_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for ${var.instance_name}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.instance_name}-sg"
    }
  )
}

# SSH Key Pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# EC2 Instance
resource "aws_instance" "instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  key_name              = aws_key_pair.ssh_key.key_name

  user_data = file("${path.module}/files/userdata.sh")

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
