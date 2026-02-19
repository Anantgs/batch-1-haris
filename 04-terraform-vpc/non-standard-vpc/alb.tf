resource "aws_lb" "testalb" {
  name               = "test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc-web.id]
  subnets            = module.vpc.public_subnets

  tags = {
    Environment = "Dev"
  }
}

resource "aws_lb_target_group" "testtg" {
  name        = "testtg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "alblistener" {
  load_balancer_arn = aws_lb.testalb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.testtg.arn
  }
}

resource "aws_lb_target_group_attachment" "tgattachment" {
  target_group_arn = aws_lb_target_group.testtg.arn
  for_each         = toset(data.aws_availability_zones.example.names)
  target_id        = aws_instance.app_server[each.value].id
  port             = 80
}