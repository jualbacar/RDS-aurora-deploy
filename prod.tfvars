env = "pro"

# In PROD we want to have read replicas in case of failover
instances = {
    1 = {
      instance_class = "db.t2.medium"
    }
    2 = {
      identifier     = "mysql-static-1"
      instance_class = "db.t2.medium"
    }
  }