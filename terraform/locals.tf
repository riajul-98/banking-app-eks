locals {
  name   = "eks-lab"
  domain = "lab.riajul-devops.com"
  region = "eu-west-2"
  tags = {
    Environment = "sandbox"
    Project     = "EKS Advanced Labs"
    Author      = "Riajul"
  }
}
