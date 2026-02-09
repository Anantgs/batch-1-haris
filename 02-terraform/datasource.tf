data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name  = "root-device-type"
    values = ["ebs"]
  }

  filter{
    name  = "architecture"
    values = [ "x86_64" ]
  }

}


output "ami_id" {
    description = "The AMI ID for the latest Amazon Linux 2"
    value = data.aws_ami.ubuntu.id
}

output "image-type"{
    description = "The image type for the latest Amazon Linux 2"
    value = data.aws_ami.ubuntu.image_type
}