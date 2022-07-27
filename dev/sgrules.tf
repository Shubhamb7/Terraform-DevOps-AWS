resource "aws_security_group_rule" "bastion_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.sg_ids[0].id
}

resource "aws_security_group_rule" "web_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  # cidr_blocks = ["0.0.0.0/0"]
  source_security_group_id = data.aws_security_group.sg_ids[0].id
  security_group_id = data.aws_security_group.sg_ids[1].id
}

resource "aws_security_group_rule" "web_http" {
  type = "ingress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.sg_ids[1].id
}

resource "aws_security_group_rule" "app_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = data.aws_security_group.sg_ids[0].id
  security_group_id = data.aws_security_group.sg_ids[2].id
}

resource "aws_security_group_rule" "app_http" {
  type = "ingress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  # cidr_blocks = ["0.0.0.0/0"]
  source_security_group_id = data.aws_security_group.sg_ids[0].id
  security_group_id = data.aws_security_group.sg_ids[2].id
}

resource "aws_security_group_rule" "db_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = data.aws_security_group.sg_ids[0].id
  security_group_id = data.aws_security_group.sg_ids[3].id
}

resource "aws_security_group_rule" "alb_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.sg_ids[4].id
}