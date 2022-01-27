variable "region"{
	default = "us-east-1"
	description = "Default Region"
}
variable "vpcidr" {
	default = "190.160.0.0/16"
	description = "Cidr value for the VPC"
}
variable "subcidr" {
	type = list
	default = ["190.160.1.0/24","190.160.2.0/24","190.160.3.0/24","190.160.4.0/24","190.160.5.0/24","190.160.6.0/24"]
	description = "Cidr value for subnets"
	sensitive = true
}
data "aws_availability_zones" "az" {}
