provider "aws"{
region = var.region
}

resource "aws_instance" "web_instance" {
  ami = var.ami-id
  instance_type = "t2.micro"
  key_name = "Nov28_key"
  vpc_security_group_ids = ["sg-0eb34957326f80e52"]
  
    provisioner "file" {
          source = "script.sh"
          destination = "/tmp/script.sh"
    }

    provisioner "remote-exec" {
          inline = [
              "chmod +x /tmp/script.sh",
              "sudo /tmp/script.sh"
          ]
    }

    connection {
      host = "${aws_instance.web_instance.public_ip}"
      user = "ec2-user"
      private_key = "${file("${var.private_key_path}")}"
      }

tags = {
    Name = var.name
}
}
