resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [aws_subnet.my_public_subnet.id, aws_subnet.my_public_subnet2.id]
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "albtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group_attachment" "alb_tga1" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.my_1st_server.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_tga2" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.my_2nd_server.id
  port             = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    type             = "forward"
  }
}