resource "aws_s3_bucket" "website_bucket" {
  bucket_prefix = "my-portfolio-"

}

resource "aws_s3_bucket_public_access_block" "s3_access" {
  bucket = aws_s3_bucket.website_bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name = "s3-cloudfront-oac"  
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

data "aws_iam_policy_document" "allow_access_from_cloudfront" {
  statement {
    actions = [ "s3:GetObject" ]
    resources = [ "${aws_s3_bucket.website_bucket.arn}/*"]

    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [aws_cloudfront_distribution.website_dist.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cdn_oac_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_cloudfront.json
}

