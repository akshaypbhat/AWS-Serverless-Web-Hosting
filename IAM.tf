resource "aws_iam_user" "github_actions" {
    name = "github-actions-deployer"

}

resource "aws_iam_access_key" "github_key" {
    user = aws_iam_user.github_actions.name
}

# Grant permission only to your specific bucket

resource "aws_iam_user_policy" "deploy_policy" {
    name = "S3DeployPolicy"
    user = aws_iam_user.github_actions.name
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = ["s3:PutObject", "s3:ListBucket", "s3:DeleteObject"]
            Resource = [aws_s3_bucket.website_bucket.arn,"${aws_s3_bucket.website_bucket.arn}/*"]
        },
        {
            Effect= "Allow"
            Action = ["cloudfront:CreateInvalidation"]
            Resource = "*"
        }
        ]
    })
}