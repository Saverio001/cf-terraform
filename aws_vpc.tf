resource "aws_vpc" "my_vpc" {
  cidr_block = "172.18.0.0/16"

  tags = {
    Name = "cloudflare-test"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.18.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "tf-public"
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "tf-public"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.rt_public.id
}
