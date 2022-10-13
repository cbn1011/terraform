provider "aws" {
region = var.region
}
#aws instance
resource "aws_instance" "example" {
ami = var.myami
instance_type = "t2.micro"
availability_zone = "us-east-1b"
key_name = "deployer-key"
root_block_device {
    volume_size           = "30"
    volume_type           = "gp2"
    delete_on_termination = true
  }
}
#ebs volume
resource "aws_ebs_volume" "myebs" {
availability_zone = "us-east-1b"
size = 30
}
#keypair section
resource "aws_key_pair" "deployer-key" {
  key_name   = "deployer-key"
 public_key = file("/root/.ssh/id_rsa.pub")
}
#resource "aws_volume_attachment" "ebs_att" {
#  device_name = "/dev/sda1"
#  volume_id   = aws_ebs_volume.myebs.id
#  instance_id = aws_instance.example.id
#}

