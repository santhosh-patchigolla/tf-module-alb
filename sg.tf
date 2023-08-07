# Public load balancer Security group
resource "aws_security_group" "alb_public" {
  count       = var.INTERNAL ? 0 : 1
  name        = "roboshop-${var.ENV}-public-alb-sg"
  description = "Allows Only Traffic to internet"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {   
    description = "http from internet"
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

  tags = {
    Name = "roboshop-${var.ENV}-public-alb-sg"
  }
}

# Private load balancer security Group
resource "aws_security_group" "alb_private" {
  count       = var.INTERNAL ? 0 : 1  
  name        = "roboshop-${var.ENV}-private-alb-sg"
  description = "Allows Only Traffic to interanet"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

    ingress {
    description = "interanet from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-private-alb-sg"
  }
}


