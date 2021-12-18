
provider "aws" {
  access_key = "AKIA2ZWHSFNS5HOOXCTP"
  secret_key = "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"
  region     = "us-east-1"
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2-terr.id
  allocation_id = aws_eip.lb.id
}
resource "aws_key_pair" "deployer-key" {
  key_name   = "deployer-key"
 public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2-terr" {
  ami           = "ami-083654bd07b5da81d"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.security.name]
  key_name = "deployer-key"


    provisioner "file" {
    source  = "apache.sh"
    destination = "/tmp/apache.sh"
connection {
    type = "ssh"
    host = aws_instance.ec2-terr.public_ip
    user = "ubuntu"
    private_key = file("/root/.ssh/id_rsa")

  }
}
   provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/apache.sh",
      "sh /tmp/apache.sh",
    ]
connection {
    type = "ssh"
    host = aws_instance.ec2-terr.public_ip
    user = "ubuntu"
    private_key = file("/root/.ssh/id_rsa")

  }

}
}

resource "aws_eip" "lb" {
  vpc      = true
}
resource "aws_security_group" "security" {
  name        = "security"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

   }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security"
  }
}

