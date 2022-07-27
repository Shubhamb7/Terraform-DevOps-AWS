resource "aws_security_group" "sg" {
  count = length(var.sg_list)
  name        = "${element(var.sg_list,count.index)}"
  description = "${element(var.sg_list,count.index)}"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-${element(var.sg_list,count.index)}"
  }
}

data "aws_security_group" "sg_ids" {
  count = length(var.sg_list)
  id = aws_security_group.sg[count.index].id
}