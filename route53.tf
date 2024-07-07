
resource "aws_route53_record" "www" {
  zone_id = "Z00541411T1NGPV97B5C0"
  name    = aws_s3_bucket.static_web.bucket
 type    = "A"

  alias {
    name  =  aws_s3_bucket.static_web.website_domain  #S3 website configuration attribute: website_domain
    zone_id = aws_s3_bucket.static_web.hosted_zone_id  # Hosted zone of the S3 bucket, Attribute:hosted_zone_id
    evaluate_target_health = true
  }
}