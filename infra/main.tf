provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "my_key" {
  key_name   = "terraform-key"
  public_key = file("/Users/yash_yy/.ssh/id_rsa.pub") 
}

resource "aws_security_group" "dev_sg" {
  name        = "devops-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["27.7.105.182/32"]  
  }

  ingress {
    description = "HTTP"
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

resource "aws_instance" "dev_instance" {
  ami           = "ami-053b0d53c279acc90"  # Ubuntu 22.04 in us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  vpc_security_group_ids = [aws_security_group.dev_sg.id]

  tags = {
    Name = "DevOpsProjectInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -aG docker ec2-user
              EOF
}