terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "dev"
}

resource "aws_instance" "web" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.instance_security_group.id}"]
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "instance_security_group"{
    name = "instance_security_group"

    ingress {    
        from_port        = 22    
        to_port          = 22   
        protocol         = "tcp"    
        cidr_blocks      = ["0.0.0.0/0"]    
        ipv6_cidr_blocks = ["::/0"]  
    }
}