# Remote State
resource "aws_s3_bucket" "remote_state" {
  bucket = "mighty-real-tf-state"
}

resource "aws_s3_bucket_policy" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "REMOTESTATE"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::036512427359:user/terraform-user"
        },
        "Action" : "s3:ListBucket",
        "Resource" : aws_s3_bucket.remote_state.arn
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::036512427359:user/terraform-user"
        },
        "Action" : ["s3:GetObject", "s3:PutObject"],
        "Resource" : "${aws_s3_bucket.remote_state.arn}/*"
      }
    ]
  })
}


# Public ALB Access Logs
resource "aws_s3_bucket" "mighty-real-public-alb-access-logs" {
  bucket = "mighty-real-public-alb-access-logs"
}

resource "aws_s3_bucket_policy" "alb-access-logs-policy" {
  bucket = aws_s3_bucket.mighty-real-public-alb-access-logs.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "PUBLICALBACCESSLOGBUCKET"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.elb_account_id}:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.mighty-real-public-alb-access-logs.arn}/*"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.mighty-real-public-alb-access-logs.arn}/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "logdelivery.elb.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.mighty-real-public-alb-access-logs.arn}/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        "Action" : "s3:GetBucketAcl",
        "Resource" : aws_s3_bucket.mighty-real-public-alb-access-logs.arn
      }
    ]
  })
}