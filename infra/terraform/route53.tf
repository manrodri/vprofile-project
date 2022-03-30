resource "aws_route53_zone" "private" {
  name = "vprofile.in"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
//
//resource "aws_route53_record" "mysql" {
//  zone_id = aws_route53_zone.private.zone_id
//  name    = "db01.${aws_route53_zone.private.name}"
//  type    = "A"
//  ttl     = "300"
//  records = [aws_eip.lb.public_ip] # mysql ip
//}
//
//resource "aws_route53_record" "memcache" {
//  zone_id = aws_route53_zone.private.zone_id
//  name    = "mc01.${aws_route53_zone.private.name}"
//  type    = "A"
//  ttl     = "300"
//  records = [aws_eip.lb.public_ip] # mysql ip
//}
//
//resource "aws_route53_record" "rabbitmq" {
//  zone_id = aws_route53_zone.private.zone_id
//  name    = "rbq01.${aws_route53_zone.private.name}"
//  type    = "A"
//  ttl     = "300"
//  records = [aws_eip.lb.public_ip] # mysql ip
//}

