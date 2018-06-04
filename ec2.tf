# create 2 ec2 instances in default vpc with openall sg
# tag them by count
# use the same user-data on both
# output the ip address of each of the instance --> public_ip = 52.43.242.225,52.41.181.122

resource "aws_instance" "web" {
  count                       = 2
  ami                         = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  user_data                   = "${file("user-data.txt")}"
  subnet_id                   = "${element(data.aws_subnet_ids.all.ids, count.index)}"
  vpc_security_group_ids      = ["${var.Security_Group}"]
  key_name                    = "${var.SSH_KeyName}"

  tags {
    Name = "web-server-${count.index}"
  }
}

output "public_ip" {
  value = "${join(",", aws_instance.web.*.public_ip)}"
}

## public_ip = 52.43.242.225,52.41.181.122

