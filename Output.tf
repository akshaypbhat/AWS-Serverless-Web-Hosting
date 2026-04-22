output "website_url" {
  value = "https://${aws_cloudfront_distribution.website_dist.domain_name}"
  description = "The public URL of your website"
}

output "aws_s3_bucket" {
  value = aws_s3_bucket.website_bucket.id
}