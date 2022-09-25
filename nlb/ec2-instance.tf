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
