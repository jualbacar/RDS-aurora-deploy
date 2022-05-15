data "aws_secretsmanager_secret_version" "database_creds" {
  secret_id = "${var.env}/rds-aurora-db-creds"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.database_creds.secret_string
  )
}

module "rds-aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.1.0"

  name           = "${var.app_name}-mysql-${var.env}"
  engine         = "aurora-mysql"
  engine_version = "5.7.12"
  instances = var.instances

  vpc_id                 = module.vpc.vpc_id
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  create_db_subnet_group = false
  create_security_group  = false
  vpc_security_group_ids = [module.security-group.security_group_id]

  iam_database_authentication_enabled = true

  create_random_password = false
  master_password = local.db_creds.master_password

  storage_encrypted = true
  kms_key_id = aws_kms_key.rds-kms-key.arn

  apply_immediately   = false
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.db_parameter-group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db_cluster_parameter-group.id
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = local.tags
}

resource "aws_db_parameter_group" "db_parameter-group" {
  name        = "${var.app_name}-aurora-db-57-parameter-group-${var.env}"
  family      = "aurora-mysql5.7"
  description = "${var.app_name}-aurora-db-57-parameter-group-${var.env}"
  tags        = local.tags
}

resource "aws_rds_cluster_parameter_group" "db_cluster_parameter-group" {
  name        = "${var.app_name}-aurora-57-cluster-parameter-group-${var.env}"
  family      = "aurora-mysql5.7"
  description = "${var.app_name}-aurora-57-cluster-parameter-group-${var.env}"
  tags        = local.tags
}


