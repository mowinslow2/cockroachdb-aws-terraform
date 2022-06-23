# Create 3 instances, one for each cockroach node
resource "aws_instance" "node" {
  count = 3
  ami = "ami-0022f774911c1d690"
  instance_type = "m5.xlarge" 
  availability_zone = "us-east-1a"
  key_name = "cockroach-morgan"

  tags = {
      Name = "cockroach_node_${count.index}" 
  }
}

# SSH into each instance and manually start each cockroach node
resource "null_resource" "node-init" {
    count       = 3
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/cockroach-morgan.pem")
    host        = aws_instance.node[count.index].public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "curl https://binaries.cockroachdb.com/cockroach-v22.1.1.linux-amd64.tgz | tar -xz",
        "sudo cp -i cockroach-v22.1.1.linux-amd64/cockroach /usr/local/bin/",
        "sudo mkdir -p /usr/local/lib/cockroach",
        "sudo cp -i cockroach-v22.1.1.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/",
        "sudo cp -i cockroach-v22.1.1.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/",
        "cockroach start --insecure --advertise-addr=${aws_instance.node[count.index].public_ip} --join=${aws_instance.node[0].public_ip},${aws_instance.node[1].public_ip},${aws_instance.node[2].public_ip} --cache=.25 --max-sql-memory=.25 --background",
    ]
  }
}