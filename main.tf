module "vpc" {
  source  = "./modules/vpc"

  name     = "terraform-demo"
  vpc_cidr = "10.10.0.0/16"
}

#output "vpc" {
#  value = module.vpc
#}

resource "aws_key_pair" "main" {
  key_name   = "terraform-demo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCBHYp4WUiu8BUxvI076of2dEt876WpURrZZy1v/kH820PazA/irSrpS5Q2wVVCqFLjT8bCrT86l22D+oAvCzPbuZTv1K3AkLmy1RU2iiln/GrVdQSkNxKmtkEMrfdwrDZaS3+kJmP/uue0MmL0KrwAwQblkoJyVPS+/6rANSAo25aQl8R8wgx9cZfguG3zF36rbvqy25rsQjar21moeBomz4QUBuWjpOmpWCy37SQHtBnWboGJ8Cw7XBQNcR6H9mRuSYU3Gzoc5BGwhxZmnu9k2bFDXp024y/CGPIIYKk0xcrBiO1+azSxbirx3/OmqDFRm7H/on21kIHyudn6zs1 shan@alphav.io"
}
