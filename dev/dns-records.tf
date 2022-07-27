resource "aws_route53_record" "web_cname_record" {
  zone_id = var.zone_id
  name    = "web"
  type    = "CNAME"
  ttl     = "15"
  records = [aws_lb.alb.dns_name]
}

# resource "aws_route53_record" "app_cname_record" {
#   zone_id = var.zone_id
#   name    = "app"
#   type    = "CNAME"
#   ttl     = "15"
#   records = [aws_instance.ec2[2].private_ip]
# }