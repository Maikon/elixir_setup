provider "aws" {
  region = "us-east-1"
}

variable "instance-name" {
  description = "The name of the instance"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

variable "ssh_port" {
  description = "The port used for ssh connections"
  default = 22
}

variable "erlang_port_mapper_daemon" {
  description = "The port used for ssh connections"
  default = 4369
}

variable "https_port" {
  description = "The port used for HTTPS connections"
  default = 443
}

resource "aws_instance" "elixir_conf_eu" {
  ami = "ami-2d39803a"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  key_name = "elixir-conf-eu-key"
  tags {
    Name = "${var.instance-name}"
  }
}

output "public_ip" {
  value = "${aws_instance.elixir_conf_eu.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.elixir_conf_eu.public_dns}"
}

resource "aws_security_group" "instance" {
  name = "${var.instance-name}-security-group"
  description = "Specifying ports for server requests, ssh access and ports used by the Erlang distribution protocol (9100-9155) and the Erlang Port Mapper Daemon(4369)"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.https_port}"
    to_port = "${var.https_port}"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.erlang_port_mapper_daemon}"
    to_port = "${var.erlang_port_mapper_daemon}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9100
    to_port = 9155
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
