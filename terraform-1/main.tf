terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}


provider "aws"{
    region = "us-east-1"
}


resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  #instance_type = "t2.micro"
  # count         = 2
  for_each      = toset(var.instance_type)
  instance_type = each.value
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data = file("apache-install.sh")

  tags = {
    Name = "learn-terraform-${each.value}"
  }
}

# output "instance_id" {
#     description = "We wil get the instance id here"
#     value = aws_instance.app_server.id
# }

output "instance_id" {
    description = "We wil get the instance id here"
    value = [ for instance in aws_instance.app_server : instance.id ]
}


