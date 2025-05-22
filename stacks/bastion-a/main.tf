module "bastion" {
  source = "../../modules/ec2"

  instance_name = "bastion-a"
  instance_type = "t3.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id
  key_name      = "bastion-a-key"

  allowed_ssh_cidr_blocks = ["10.0.0.0/8"]  # Note: In production, you should restrict this to your IP range

  tags = {
    Environment = "Lab-A"
    Purpose     = "Bastion Host"
  }
}

# Reference the existing VPC stack's outputs
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc-a/terraform.tfstate"
  }
}
    