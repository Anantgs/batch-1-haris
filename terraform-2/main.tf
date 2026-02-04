variable "instance_map" {
  type = map(string)
  default = {
    "Instance-A" = "t2.micro"
    "Instance-B" = "t3.micro"
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  #instance_type = "t2.micro"
  # count         = 2
  for_each      = var.instance_map
  instance_type = each.value
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  #user_data = file("apache-install.sh")

  tags = {
    Name = "learn-terraform-${each.key}"
  }
}

output "instance_id" {
    description = "We will create instance id map here"
    value = { for key , instance in aws_instance.app_server : key => instance.id }
}