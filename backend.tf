terraform {
  backend "gcs" {
    bucket = "gcp_demo"
    prefix = ""
  }
}