#################################################
# Latest Amazon Linux 2 AMI
#################################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
  name   = "name"
  values = ["amzn2-ami-hvm-*-x86_64-gp2"]
}

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#################################################
# EC2 Instance
#################################################

resource "aws_instance" "app_server" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

 subnet_id = var.public_subnet_ids[0]

  vpc_security_group_ids = [
    var.ec2_security_group_id
  ]

  iam_instance_profile = var.instance_profile_name

  associate_public_ip_address = true

  #################################################
  # Root Volume
  #################################################

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  #################################################
  # Metadata Service (IMDSv2)
  #################################################

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  #################################################
  # User Data
  #################################################

 user_data = <<-EOF
#!/bin/bash

yum update -y

systemctl enable amazon-ssm-agent
systemctl restart amazon-ssm-agent
systemctl status amazon-ssm-agent

EOF

  #################################################
  # Tags
  #################################################

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-app-server"
    }
  )
}