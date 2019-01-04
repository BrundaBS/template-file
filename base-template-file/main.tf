resource "null_resource" "copy-template-file" {
    provisioner "file" {
    source      = "assets/template-file"
    destination = "/tmp"

    connection {
      host        = "${local.bifrost_ip}"
      timeout     = "300s"
      type        = "ssh"
      port        = 22
      user        = "gcp_user"
      private_key = "${local.ssh_key}"
    }
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/template-file /home/halyard/template-file-manifests/",
      "sudo chown -R halyard:halyard /home/halyard/template-file-manifests",
      "sudo -H -u halyard bash -c 'bash /home/halyard/template-file-manifests/scripts/addfile.sh",
    ]

    connection {
      host        = "${local.bifrost_ip}"
      timeout     = "300s"
      type        = "ssh"
      port        = 22
      user        = "gcp_user"
      private_key = "${local.ssh_key}"
    }
  }


}
