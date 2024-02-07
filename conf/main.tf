
module "aws-config" {
  source = "./modules/aws-config/"
}

module "sns" {
  source = "./modules/sns/"
}

module "S3" {
  source = "./modules/S3/"
}










