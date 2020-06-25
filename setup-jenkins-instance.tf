data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

resource "aws_instance" "jenkins-instance"{
    ami = data.aws_ami.amazon-linux-2.id
    instance_type = var.instance_type
    key_name = var.keyname
    vpc_security_group_ids = [aws_security_group.jenkins_server_sgs.id]
    subnet_id = data.aws_subnet.public[0].id
    user_data = file("install-jenkins.sh")
    associate_public_ip_address  = true
    tags = {
        Name = "jenkins-instance"
    }
}

resource "aws_security_group" "jenkins_server_sgs" {
  name        = "Jenkins Server Security Group"
  description = "Jenkins traffic"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "<desired public ip>/32"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "<desired public ip>/32"]
  }

  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "jenkins_ip_address" {
  value = aws_instance.jenkins-instance.public_dns
}