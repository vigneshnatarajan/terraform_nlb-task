data "aws_ami" "amazon-linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

data "aws_lb_target_group" "tcp-udp" {
 depends_on = [module.nlb] 
 name = var.tcp_udp_tg
}
 
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.instane_type
  key_name = var.key_name
  subnet_id = var.ec2_subnet_id
  root_block_device {
   volume_size = 30
   volume_type = "gp2"
  }
  tags = {
    Name = var.ec2_name
  }
}

resource "aws_security_group_rule" "defaultallow" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default.cidr_block]
  security_group_id = data.aws_security_group.default.id
}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = data.aws_lb_target_group.tcp-udp.arn
  target_id        = aws_instance.web.id
  port             = 80
}
