resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc = true

  tags = {
    Name = "bastion"
  }
}

resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.main.key_name
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [ aws_security_group.bastion.id ]

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }

  tags = {
    Name = "bastion"
  }
}

output "bastion_ip" {
  value = aws_eip.bastion.public_ip
}
