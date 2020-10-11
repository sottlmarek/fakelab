provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "hackitecttestbucket"
  acl    = "private"

  tags = {
    Name        = "Mareks test bucket"
    Environment = "Test"
  }
}

resource "aws_vpc" "hackiVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "HAckitectTestVPC"
    Environment = "Test"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.hackiVPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "HackitectSubnetPrivate"
  }
}

resource "aws_network_acl" "myACL" {
  vpc_id = aws_vpc.hackiVPC.id
  subnet_ids=list(aws_subnet.my_subnet.id)
  
  # NACLS are stateless 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "165.225.72.204/32"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "165.225.72.204/32"
    from_port  = 443
    to_port    = 443
  }

  tags = {
    Name = "HackitectNACL"
  }
  }

  

