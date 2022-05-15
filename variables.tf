variable "region" {
  description = "Region in which to deploy the AWS resources"
  default     = "eu-west-1"
  type        = string
}

variable env {
  description   = "Environment where the RDS cluster will be deployed"
  type          = string
}

variable app_name {
  description   = "Application/Service name for the RDS cluster"
  default       = "app-backend"
  type          = string
}

variable instances {
  description = "Instances types for RDS cluster"
  type = map
}

