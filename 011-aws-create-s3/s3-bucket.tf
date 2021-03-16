resource "aws_s3_bucket" "sumitgupta28-s3-backend" {
  bucket = "sumitgupta28-s3-backend"
  acl    = "private"

  tags = {
    Name        = "sumitgupta28-s3-backend"
    Environment = "Dev"
  }

  provisioner "local-exec" {
    command = "echo ${aws_s3_bucket.sumitgupta28-s3-backend.arn} >> arn.txt"
  }

}