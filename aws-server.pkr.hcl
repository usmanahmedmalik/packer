packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source = "github.com/hashicorp/amazon"
    }
  }
}

variable "infra_name" {
  type = string
  default = "usman"
}

variable "infra_env" {
  type = string
  default = "staging"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "region" {
  type = string
  default = "eu-central-1"
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.infra_name}-${var.infra_env}-{{timestamp}}"
  instance_type = "${var.instance_type}"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name                = "debian-10-amd64-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["136693071363"]
  }
  profile = "personal"
  ssh_username = "admin"
}

build {
  name    = "learn-packer"
  sources = [
  "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script =  "scripts/base.sh"
  }
}

