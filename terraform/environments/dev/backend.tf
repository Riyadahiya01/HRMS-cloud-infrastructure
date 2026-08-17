terraform {
  backend "s3" {
    bucket = "hrms-terraform-state-2026-462590323265"
    key    = "hrms/dev/terraform.tfstate"
    region = "ap-south-1"

    encrypt = true

    use_lockfile = true
  }
}