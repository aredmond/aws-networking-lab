module "vpc" {
  source = "../../modules/vpc"

  aws_region           = "us-east-1"
  environment          = "Lab-A"
  vpc_cidr             = "10.0.0.0/20"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}