###################
# Remote State
###################
data "aws_s3_bucket" "remote_state" {
  bucket = "mightyreal-tf-state"
}

resource "aws_s3_bucket_policy" "remote_state" {
  bucket = data.aws_s3_bucket.remote_state.id
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
        "Resource" : data.aws_s3_bucket.remote_state.arn
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::036512427359:user/terraform-user"
        },
        "Action" : ["s3:GetObject", "s3:PutObject"],
        "Resource" : "${data.aws_s3_bucket.remote_state.arn}/*"
      }
    ]
  })
}


###################
# Access Logs
###################
resource "aws_s3_bucket" "access_logs" {
  bucket = "mightyreal-access-logs"
}

resource "aws_s3_bucket_policy" "access_logs" {
  bucket = aws_s3_bucket.access_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "PUBLICACCESSLOGBUCKET"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.elb_account_id}:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.access_logs.arn}/*"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.access_logs.arn}/*",
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
        "Resource" : "${aws_s3_bucket.access_logs.arn}/*",
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
        "Resource" : aws_s3_bucket.access_logs.arn
      }
    ]
  })
}