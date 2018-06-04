##  https://github.com/terraform-aws-modules/terraform-aws-security-group
resource "aws_security_group" "lbsg" {
  count = "1"

  name        = "LB_Security_Group"
  description = "LB_Security_Group"
  vpc_id      = "${data.aws_vpc.default.id}"
}

resource "aws_security_group_rule" "ingress_rules" {
  security_group_id = "${aws_security_group.lbsg.id}"
  type              = "ingress"

  cidr_blocks = ["0.0.0.0/0"]
  description = "Enable HTTP only"

  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"
}

resource "aws_security_group_rule" "egress_rules" {
  security_group_id = "${aws_security_group.lbsg.id}"
  type              = "egress"

  source_security_group_id = "${var.Security_Group}"
  description              = "Enable HTTP only"

  from_port = "8080"
  to_port   = "8080"
  protocol  = "tcp"
}
