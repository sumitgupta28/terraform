
data "template_file" "shell-script" {
  template = file("scripts/startup-script.sh")
}

data "template_cloudinit_config" "cloudinit-startup-script" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}

