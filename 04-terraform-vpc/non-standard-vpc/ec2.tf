variable "instance_map" {
  type = map(string)
  default = {
    "Instance-A" = "t2.micro"
    "Instance-B" = "t3.micro"
  }
}

variable "aws_azs" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}



resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.example.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data                   = file("apache-install.sh")
  for_each                    = zipmap(var.aws_azs, module.vpc.public_subnets)
  subnet_id                   = each.value
  associate_public_ip_address = true

  tags = {
    Name = "learn-terraform-${each.key}"
  }
}

output "instance_id" {
  description = "We will create instance id map here"
  value       = { for key, instance in aws_instance.app_server : key => instance.id }
}
