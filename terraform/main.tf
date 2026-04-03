provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ec10929233384c7f" # Ubuntu (update if needed)
  instance_type = "t2.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "ci-cd-server"
  }
}

resource "aws_security_group" "allow_all" {
  name = "allow_all"
  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
}


