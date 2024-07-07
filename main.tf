resource "aws_s3_bucket" "static_web" {
  bucket = "jeffstaticwebsite.sctp-sandbox.com"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "enable_public_access" {
  bucket = aws_s3_bucket.static_web.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.static_web.id
  policy = data.aws_iam_policy_document.bucket_policy.json

  depends_on = [ aws_s3_bucket_public_access_block.enable_public_access ]
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject", 
    ]
    resources = [
      "${aws_s3_bucket.static_web.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_web.id
  index_document {
    suffix = "index.html"
}
}

