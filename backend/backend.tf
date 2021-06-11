terraform {
  backend "s3" {
    bucket = "nick-remote-backend-2020"
    key = "terraform/tfstate.tfstate"
    region = "us-east-1"
    access_key = ""
    secret_key = ""
  }
}
