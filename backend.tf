terraform {
  backend "s3" {
    bucket       = "project-03-tfstate-057481081655-ap-south-1"
    key          = "project-03/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
