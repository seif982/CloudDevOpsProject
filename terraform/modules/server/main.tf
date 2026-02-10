# رادار لجلب أحدث AMI لـ Ubuntu 22.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # المالك الرسمي لـ Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "jenkins" {
 ami           = data.aws_ami.ubuntu.id
  
  # التعديل هنا: هنغير النوع لـ t2.small
  # ساعات بعض الحسابات التعليمية أو المحددة بترفض الـ micro وبتطلب small
  instance_type = "t3.micro" 
  
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true
  key_name                    = "Task30"   # المفتاح اللي اتأكدنا إنه عندك

  tags = {
    Name = "Jenkins-Server"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow SSH and Jenkins inbound traffic"
  vpc_id      = var.vpc_id

  # بورت الـ SSH عشان Ansible يعرف يدخل
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # بورت الـ Jenkins الافتراضي
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # السماح لكل الزيارات الخارجة (عشان السيرفر يعرف يحمل برامج)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_sg"
  }
}
