/*
#resource "aws_s3_bucket" "tf_state" {
#  bucket = "devops-ror-app-tfstate-bucket"
#  versioning {
#    enabled = true
#  }

#  lifecycle {
#    prevent_destroy = false
#  }

#  tags = {
#    Name = "Terraform State Bucket"
#  }
}
*/

/*
# Separate encryption configuration (new recommended way)
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_sse" {
#  bucket = aws_s3_bucket.tf_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
*/
