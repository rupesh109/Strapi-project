resource "aws_lb" "strapi_alb" {
  name               = "strapi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "strapi-alb"
  }
}

resource "aws_lb_target_group" "strapi_sg" {
  name     = "strapi-sg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = aws_vpc.strapi_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-499"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  target_type = "ip"
}

resource "aws_lb_listener" "strapi_listener" {
  load_balancer_arn = aws_lb.strapi_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi_tg.arn
  }
}
# ALB Target Group for Strapi
resource "aws_lb_target_group" "strapi_tg" {
  name        = "strapi-tg"
  port        = 1337
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.strapi_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}
