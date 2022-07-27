resource "aws_instance" "ec2" {

  count = length(var.server_list)
  ami = var.ami
  instance_type = element(var.instance_type_list,count.index)
  subnet_id = element(var.instance_subnet_list,count.index) != "public" ? aws_subnet.private_subnet[0].id : aws_subnet.public_subnet[0].id
  vpc_security_group_ids = ["${data.aws_security_group.sg_ids[count.index].id}"]
  key_name = var.keypair
  
  user_data = templatefile("${lookup(var.user_data_map, element(var.server_list,count.index))}",{Name = element(var.server_list,count.index)})
  
  depends_on = [aws_subnet.private_subnet, aws_subnet.public_subnet, aws_security_group.sg]

  tags = {
    Name = "${element(formatlist("${var.env}-%s",var.server_list),count.index)}"
  }
}
