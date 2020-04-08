resource "aws_security_group" "app" {
  name        = "app"
  description = "Allow Internal"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow Internal Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [ module.vpc.vpc_cidr ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app"
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.main.key_name

  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [ aws_security_group.app.id ]
  associate_public_ip_address = false

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }

  tags = {
    Name = "app"
  }
}

resource "null_resource" "cluster" {
  triggers = {
    checksum = filemd5("run.sh")
  }

  connection {
    type         = "ssh"
    user         = "ubuntu"
    host         = aws_instance.app.private_ip
    bastion_host = aws_eip.bastion.public_ip
    bastion_user = "ubuntu"
    agent        = true
  }

  provisioner "remote-exec" {
    script = "run.sh"
  }
}

output "app_ip" {
  value = aws_eip.bastion.private_ip
}
