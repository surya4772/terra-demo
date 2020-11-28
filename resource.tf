resourse "aws_key_pair" "mykey_pair" {
	key_name = "newkey"
	public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOkdLfjF/oLvM79NR+iduyoGv3f2TAeG4LAqQtsy4lHUojHR8Sz93WGv9pLo9uKzBKXe+AUmJafBgqi+QImnkX9mpJaOHiLYhHTEKmqdnwy1kuTj2Wq+WiKwLVSCclwGBGjKPjZMB5QQCJ+T4Ubk0AmAgOo4D+HTXk6skvwIJa4WDS+gm+drhjDoPFYufTCefQhPoIaXk9dZT7gUfZq4WkaO+g+btqigpa4nDuTfD+EzkSvXITP5jF0YI0bXrcEEvTbtQ5HCBxa97IlsJgYarGpnaDI2tsC4Qhl22V8EQeEC8qx1Fek2qy4yLsSK0NvZ3ZTJBgPcU5NKohMeNnqrRwjRImw9KF6C0gCn5ZAkIcQWadD/27qnex/aftDJYUzdR7JC16g4IAORieO33PUBnY10a9xRMNrEYuOz0IPallvin8dfyF8eNSlHTCNZkXo54uOwMrBkvfmhvXCnjTzOkqJnB/1C38EVXylKk5QSH5kTu3AuhO9z55NuhZRDjfrhs= root@ip-172-31-17-50.ec2.internal"
}

resourse "aws_instance" "myinstance" {
	ami = "ami-096fda3c22c1c990a"
	instance_type = "t2.micro"
	key_name = aws_key_pair.mykey_pair.key_name
	tags = {
		Name = "eleasticsearch"
	}
	provisioner "file" {
		source = "elasticsearch.sh"
		destination = "/tmp/elasticsearch.sh"
	}

	provisioner "remote-exec" {
		inline = [
		"chmod u+x /tmp/elasticsearch.sh",
		"sudo /tmp/elasticsearch.sh"
		]
	}
	connection {
		user = "ec2-user"
		private_key = file("mykey")
		host = self.private_ip
	}
}
