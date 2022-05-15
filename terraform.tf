terraform {
    backend "s3" {
        bucket         = "tf-state20220515193459627500000001"  # this bucket name needs to be hardcoded as backend configuration does not support variable references
        key            = "state/rds-aurora-terraform.tfstate"
        region         = "eu-west-1"
        encrypt        = true
        kms_key_id     = "alias/tf-state-bucket-key"
        dynamodb_table = "terraform-state"
    }
}
