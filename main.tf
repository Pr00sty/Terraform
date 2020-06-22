provider "aws" {
  profile    = "default"
  region     = "eu-west-1"
}

resource "aws_vpc" "Paw_main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Paw_VPC"
  }
}

resource "aws_subnet" "PUB_1" {
  vpc_id = "${aws_vpc.Paw_main_vpc.id}"
  availability_zone = "eu-west-1a"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "SN_PUB_1"
  }
}

resource "aws_subnet" "PUB_2" {
  vpc_id = "${aws_vpc.Paw_main_vpc.id}"
  availability_zone = "eu-west-1b"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "SN_PUB_2"
  }
}

resource "aws_subnet" "PUB_3" {
  vpc_id = "${aws_vpc.Paw_main_vpc.id}"
  availability_zone = "eu-west-1c"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "SN_PUB_3"
  }
}

resource "aws_subnet" "PRIV_1" {
  vpc_id = "${aws_vpc.Paw_main_vpc.id}"
  availability_zone = "eu-west-1a"
  cidr_block = "10.0.11.0/24"
  tags = {
    Name = "SN_PRIV_1"
  }
}

resource "aws_subnet" "PRIV_2" {
  vpc_id = "${aws_vpc.Paw_main_vpc.id}"
  availability_zone = "eu-west-1b"
  cidr_block = "10.0.22.0/24"
  tags = {
    Name = "SN_PRIV_2"
  }
}

resource "aws_subnet" "PRIV_3" {
  vpc_id = "${aws_vpc.Paw_main_vpc.id}"
  availability_zone = "eu-west-1c"
  cidr_block = "10.0.33.0/24"
  tags = {
    Name = "SN_PRIV_3"
  }
}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.PUB_1.id}"

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
