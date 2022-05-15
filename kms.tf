## KMS key for RDS cluster storage encryption

resource "aws_kms_key" "rds-kms-key" {
    description             = "This key is used to encrypt RDS cluster storage"
    deletion_window_in_days = 10
    enable_key_rotation     = true
}

resource "aws_kms_alias" "key-alias" {
    name          = "alias/${var.app_name}-${var.env}-rdscluster-key"
    target_key_id = aws_kms_key.rds-kms-key.key_id
}