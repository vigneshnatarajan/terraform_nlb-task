provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/home/ec2-user/.aws/config"]
  shared_credentials_files = ["/home/ec2-user/.aws/credentials"]
  profile                  = "default"
}

#locals {
#  domain_name = "terraform-aws-modules.modules.tf"
#}

##################################################################
# Data sources to get VPC and subnets
##################################################################
data "aws_vpc" "default" {
  default = true
}


resource "random_pet" "this" {
  length = 2
}

#data "aws_route53_zone" "this" {
#  name = local.domain_name
#}

# module "log_bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "~> 3.0"
#
#   bucket                         = "logs-${random_pet.this.id}"
#   acl                            = "log-delivery-write"
#   force_destroy                  = true
#   attach_elb_log_delivery_policy = true
# }

#module "acm" {
#  source  = "terraform-aws-modules/acm/aws"
#  version = "~> 3.0"

#  domain_name = local.domain_name # trimsuffix(data.aws_route53_zone.this.name, ".")
#  zone_id     = data.aws_route53_zone.this.id
#}


##################################################################
# Network Load Balancer with Elastic IPs attached
##################################################################
module "nlb" {
  source = "../modules/"

  name = var.nlb_name

  load_balancer_type = "network"

  vpc_id = var.vpc_id

  #   Use `subnets` if you don't want to attach EIPs
  subnets = var.subnet_list


  #  TCP_UDP, UDP, TCP
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP_UDP"
      target_group_index = 0
    },
    {
      port               = 82
      protocol           = "UDP"
      target_group_index = 1
    },
    {
      port               = 83
      protocol           = "TCP"
      target_group_index = 2
    },
  ]

  target_groups = [
    {
      name            = var.tcp_udp_tg
      backend_protocol       = "TCP_UDP"
      backend_port           = 80
      target_type            = "instance"
      connection_termination = true
      preserve_client_ip     = true
      tags = {
        tcp_udp = true
      }
    },
    {
      name      = var.udp_tg
      backend_protocol = "UDP"
      backend_port     = 82
      target_type      = "instance"
    },
    {
      name          = var.tcp_tg
      backend_protocol     = "TCP"
      backend_port         = 83
      target_type          = "ip"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthz"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
      }
    },
    {
      name      = var.tls_tg
      backend_protocol = "TLS"
      backend_port     = 84
      target_type      = "instance"
    },
  ]
}
