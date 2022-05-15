# RDS-aurora-deploy

This stack creates a VPC and an RDS Aurora cluser with MySQL engine.

## Usage

* Create the secret manually for the master password db. To do it so, go to the AWS Secrets Manager console and create a new secret. The key name has to be “master_password”. Generate a strong password with you tool of choice.

* Modify the file ‘terraform.tf’, paste there the name of your tf state bucket in the bucket option.

* Create a new workspace with the name of the environment you want to deploy

```terraform workspace new dev```

* Select the workspace to work in. “terraform workspace new dev”

```terraform workspace select dev```

* Run the init, plan and apply with Terraform:

```
terraform init

terraform plan --var-file=./vars/dev.tfvars (validate everything is correct)

terraform apply -var-file=./vars/dev.tfvars (confirn with a yes)
```



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds-aurora"></a> [rds-aurora](#module\_rds-aurora) | terraform-aws-modules/rds-aurora/aws | 7.1.0 |
| <a name="module_security-group"></a> [security-group](#module\_security-group) | terraform-aws-modules/security-group/aws | 4.9.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.db_parameter-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_kms_alias.key-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.rds-kms-key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_rds_cluster_parameter_group.db_cluster_parameter-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_secretsmanager_secret_version.database_creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application/Service name for the RDS cluster | `string` | `"app-backend"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment where the RDS cluster will be deployed | `string` | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | Instances types for RDS cluster | `map` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region in which to deploy the AWS resources | `string` | `"eu-west-1"` | no |

## Outputs

No outputs.
