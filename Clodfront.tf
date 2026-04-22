resource "aws_cloudfront_distribution" "website_dist" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html" # Tells CloudFront what to load first
 
  # 1. The Link to S3
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id                = "S3-${aws_s3_bucket.website_bucket.id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }
 
  # 2. Caching Behavior (How it treats your files)
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.website_bucket.id}"
 
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
 
    viewer_protocol_policy = "redirect-to-https" # Security! Forces SSL
    min_ttl                = 0
    default_ttl            = 3600  # 1 hour
    max_ttl                = 86400 # 24 hours
  }
 
  # 3. Where to serve the site (Global/Price Class)
  price_class = "PriceClass_100" # Use only North America and Europe (cheapest)
  # For Bangalore, use "PriceClass_All" for maximum speed in India
 
  # 4. Restrictions & SSL
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
 
  viewer_certificate {
    cloudfront_default_certificate = true # Uses the *.cloudfront.net certificate for now
  }
 
  tags = {
    Name = "Freelance-Portfolio-CDN"
  }
}