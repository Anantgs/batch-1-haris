variable "instance_map" {
  type = map(string)
  default = {
    "Instance-A" = "t2.micro"
    "Instance-B" = "t3.micro"
  }
}

resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.example.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data                   = file("apache-install.sh")
  for_each                    = zipmap(data.aws_availability_zones.example.names, module.vpc.public_subnets)
  subnet_id                   = each.value
  associate_public_ip_address = true

  tags = {
    Name = "learn-terraform-${each.key}"
  }
}
