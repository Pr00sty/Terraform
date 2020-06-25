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

resource "aws_eip" "pub_1" {
  vpc              = true
}

resource "aws_eip" "pub_2" {
  vpc              = true
}
resource "aws_eip" "pub_3" {
  vpc              = true
}

resource "aws_nat_gateway" "nat_gw_pub_1" {
  allocation_id = aws_eip.pub_1.id
  subnet_id     = aws_subnet.pub_1.id

  tags = {
    Name = "NAT_GW_PUB_1"
  }
}

resource "aws_nat_gateway" "nat_gw_pub_2" {
  allocation_id = aws_eip.pub_2.id
  subnet_id     = aws_subnet.pub_2.id

  tags = {
    Name = "NAT_GW_PUB_2"
  }
}
resource "aws_nat_gateway" "nat_gw_pub_3" {
  allocation_id = aws_eip.pub_3.id
  subnet_id     = aws_subnet.pub_3.id

  tags = {
    Name = "NAT_GW_PUB_3"
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

resource "aws_route_table" "priv_1_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_pub_1.id
  }
  tags = {
    Name = "priv_1_rt"
  }
}

resource "aws_route_table" "priv_2_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_pub_2.id
  }
  tags = {
    Name = "priv_2_rt"
  }
}

resource "aws_route_table" "priv_3_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_pub_3.id
  }
  tags = {
    Name = "priv_3_rt"
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

resource "aws_lb_target_group" "main_target_group" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
  health_check {
    protocol = "HTTP"
    path = "/"
    port = "traffic-port"
    healthy_threshold = "5"
    unhealthy_threshold = "2"
    timeout = "5"
    interval = "30"
    matcher = "200"
  }
}

resource "aws_lb" "main_app_lb" {
  name               = "main-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_ssh_http.id]
  subnets            = [aws_subnet.pub_1.id, aws_subnet.pub_2.id, aws_subnet.pub_3.id]

  enable_deletion_protection = false

  tags = {
    Name = "main_app_load_balancer"
  }
}

resource "aws_instance" "ubuntu" {
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

resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main_target_group.arn
  target_id        = aws_instance.ubuntu.id
  port             = 80
}

resource "aws_placement_group" "main" {
  name     = "main-placement-group"
  strategy = "cluster"
}

resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = var.httpd_ubuntu_ami_id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "main_as_group" {
  name                      = "main-autoscaling-group"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  placement_group           = aws_placement_group.main.id
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = [aws_subnet.priv_1.id, aws_subnet.priv_2.id, aws_subnet.priv_3.id]

  tag {
    key                 = "Name"
    value               = "bar"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}