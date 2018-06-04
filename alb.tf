### create a alb - internet facing
## target group as private ip on vpc
### assign open all security group

resource "aws_lb_target_group" "web-trg-grp" {
  name     = "web-trg-grp"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.default.id}"

  health_check {
    port                = "8080"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    interval            = "10"
  }
}

resource "aws_alb_target_group_attachment" "web_trg_grp_attach" {
  count            = 2
  target_group_arn = "${aws_lb_target_group.web-trg-grp.arn}"
  target_id        = "${element(aws_instance.web.*.id, count.index)}"
}

resource "aws_alb" "alb-web" {
  name            = "alb-web"
  subnets         = ["${data.aws_subnet_ids.all.ids}"]
  security_groups = ["${aws_security_group.lbsg.id}"]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.alb-web.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.web-trg-grp.id}"
    type             = "forward"
  }
}

output "dns_name" {
  value = "${aws_alb.alb-web.dns_name}"
}
