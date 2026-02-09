
# Only Availability Zones (no Local Zones)
data "aws_availability_zones" "example" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

output "availability_zone_names" {
    description = "List of availability zone names"
    value = data.aws_availability_zones.example.names
}

data "aws_ec2_instance_type_offerings" "example-offerings" {

  for_each = toset(data.aws_availability_zones.example.names)

  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}

output "aws_instance_offerings" {
    description = "List of instance offerings"
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.example-offerings : az => details.instance_types
    }
}

