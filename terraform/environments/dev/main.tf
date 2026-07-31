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







module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment

  bucket_arn = module.s3.bucket_arn

  common_tags = local.common_tags
}





module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class
  allocated_storage = var.allocated_storage

  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  rds_security_group_id = module.security.rds_security_group_id

  common_tags = local.common_tags
}