
module "aws-config" {
  source = "./modules/aws-config/"
#  aws_config_role = module.iam_role.aws_config_role
#  depends_on = [
#    module.iam_role 
#  ]
}

module "sns" {
  source = "./modules/sns/"
}

module "S3" {
  source = "./modules/S3/"
}

#module "Iam" {
#  source = "./modules/Iam/"
#}









