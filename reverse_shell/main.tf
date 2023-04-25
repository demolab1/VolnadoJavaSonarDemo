provider "aws"  {
  region = "${var.region}"
}



# resource "aws_internet_gateway" "gw" {
 # vpc_id = "${aws_vpc.main.id}"

  #tags = {
 #   Name = "tmp_vulnado_rev_shell_igw"
 # }
#}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "tmp_vulnado_rev_shell_rt"
  }
}



resource "aws_route_table_association" "assoc" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.r.id}"
}




resource "aws_key_pair" "attacker" {
  key_name   = "tmp-vulnado-deploy-key"
  public_key = "${var.public_key}"
}

/*
  resource "aws_instance" "receiver" {
  ami           = "${data.aws_ami.amznlinux.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet.id}"
  key_name = "${aws_key_pair.attacker.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  user_data = <<EOF
#!/bin/bash
yum update
yum install -y nmap
EOF
  tags = {
    Name = "VulnadoReverseShellReceiver"
  }
    
}
*/
