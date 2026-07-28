module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnets = var.public_subnets

  private_app_subnets = var.private_app_subnets

  private_db_subnets = var.private_db_subnets

  common_tags = local.common_tags
}




module "security" {
  source = "../../modules/security"

  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}







module "s3" {
  source = "../../modules/s3"

  bucket_name = var.bucket_name

  project_name = var.project_name
  environment  = var.environment

  common_tags = local.common_tags
}