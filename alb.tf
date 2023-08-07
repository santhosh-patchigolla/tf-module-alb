# Creating application load balancer
resource "aws_lb" "test" {
  name               = var.ALB_NAME
  internal           = var.INTERNAL        //if this is true its a public load balacer since its a falce its public load balancer
  load_balancer_type = "application"
  security_groups    = var.INTERNAL ? [aws_security_group.alb_private.id] : [aws_security_group.alb_public.id]           // these are conditions in terrafrom if its true exucute the first one or the secon one
  subnets            = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS : data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS
  
 # enable_deletion_protection = true  # using this option we cannot delete the resource usntil it false or remove from the code

/* access_logs {
  bucket  = aws_s3_bucket.lb_logs.id  # Using this option we can extract the logs in the s3 bucket.
  prefix  = "test-lb"
    enabled = true
  } */

  tags = {
    Environment = "production"
  }
}
