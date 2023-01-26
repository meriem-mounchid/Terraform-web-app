  # provisioner "remote-exec" {
  #   script = "/Users/meriemmounchid/Desktop/Terraform/tools/script.sh"
  #   connection {
  #     type = "ssh"
  #     host = self.public_ip
  #     user = "ubuntu"
  #     private_key = file("/Users/meriemmounchid/Desktop/Terraform/myboomi.cer")
  #   }
  # }