provider "aws" {
  profile    = "default"
  region     = "eu-west-1"
}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  
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