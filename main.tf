terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }

    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

provider "cloudflare" {

}




resource "aws_security_group" "http_access" {
  name        = "http_ssh_access"
  description = "Allows only http, https and shh"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "webserver" {
  source            = "./webserver"
  key_name          = "aws"
  vpc_id            = aws_vpc.my_vpc.id
  subnet_id         = aws_subnet.my_subnet.id
  security_group_id = aws_security_group.http_access.id
  depends_on        = [aws_route_table_association.public_subnet_association]
}
