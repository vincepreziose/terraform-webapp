terraform {
  backend "s3" {
    bucket = "mighty-real-tf-state"
    key    = "mrd-statefile"
    region = "us-west-2"
  }
}