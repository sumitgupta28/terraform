
data "template_file" "shell-script" {
  template = file("scripts/install-apache.sh")
}

data "template_cloudinit_config" "cloudinit-startup-script" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}

