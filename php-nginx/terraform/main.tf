provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dockerhost" {
  ami           = "ami-0df8c184d5f6ae949" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  # Associate the security group
  security_groups = [aws_security_group.docker_sg.id]
  #iam_instance_profile = aws_iam_instance_profile.ecs_ecr_instance_profile.name
  key_name      = "won_ls_key"

  tags = {
    Name = "dockerhost"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker jq",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/won_ls_key.pem")
    host        = self.public_ip
  }
}
