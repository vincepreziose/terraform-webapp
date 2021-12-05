terraform {
  backend "s3" {
    bucket = "mightyreal-tf-state"
    key    = "mrd-statefile"
    region = "us-west-2"
  }
}