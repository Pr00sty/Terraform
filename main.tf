provider "aws" {
  profile    = "default"
  region     = "eu-west-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Paw_VPC"
  }
}

resource "aws_subnet" "pub_1" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "eu-west-1a"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "SN_PUB_1"
  }
}

resource "aws_subnet" "pub_2" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "eu-west-1b"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "SN_PUB_2"
  }
}

resource "aws_subnet" "pub_3" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "eu-west-1c"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "SN_PUB_3"
  }
}

resource "aws_subnet" "priv_1" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "eu-west-1a"
  cidr_block = "10.0.11.0/24"
  tags = {
    Name = "SN_PRIV_1"
  }
}

resource "aws_subnet" "priv_2" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "eu-west-1b"
  cidr_block = "10.0.22.0/24"
  tags = {
    Name = "SN_PRIV_2"
  }
}

resource "aws_subnet" "priv_3" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = "eu-west-1c"
  cidr_block = "10.0.33.0/24"
  tags = {
    Name = "SN_PRIV_3"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "pub_rt"
  }
}

resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "priv_rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub_1.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub_2.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.pub_3.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub_1.id

  root_block_device {
        delete_on_termination = "true"
        volume_size           = "8"
        volume_type           = "standard"
	}

  tags = {
    Name = "Ubuntu-ec2"
    Purpose = "tutorial"
    Repo = "github.com/Pr00sty/Terraform_first_steps.git"
  }
}
