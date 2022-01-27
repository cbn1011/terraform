provider "aws" {
 	region = var.region
	}
resource "aws_vpc" "main" {
	cidr_block	= var.vpcidr
	instance_tenancy = "default"

	tags = {
		Name = "Main"
	}
}
resource "aws_subnet" "subnets" {
	count = length(data.aws_availability_zones.az.names)
	availability_zone = element(data.aws_availability_zones.az.names,count.index)
	vpc_id	= aws_vpc.main.id
	cidr_block =  element(var.subcidr,count.index)

		tags = {
		Name = "Subnet-1"
}
}
