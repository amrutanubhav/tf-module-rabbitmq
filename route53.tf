resource "aws_route53_record" "dns-record" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_ID
  name    = "${var.COMPONENT}-dev.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_NAME}"
  type    = "A"
  ttl     = 10
  records = [aws_spot_instance_request.rabbitmq.private_ip]
}