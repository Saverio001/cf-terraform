data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "webserver" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = "t3.nano"
  key_name                    = var.key_name
  user_data                   = templatefile("${path.module}/user_data.tftpl",
  { webserver_name=var.webserver_name,
    webserver_domain=var.webserver_domain
  }
  )
  associate_public_ip_address = "true"
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_group_id]
  lifecycle {
    ignore_changes = [
      security_groups,
    ]
  }
}

resource "aws_eip" "webserver_eip" {
  instance = aws_instance.webserver.id
  domain   = "vpc"
}
