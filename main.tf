terraform {
  required_version = ">= 0.12"
  
  backend "s3" {
    bucket         = "jack-pawsey-staging-terraform-state"
    key            = "centralized-logging.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "staging-terraform-state-locks"
    encrypt        = true
  }
}

module "calm" {
  source = "git@gitlab.com:simply-calm/terraform-module.git"
  
  name = "calm"

  env = "staging"
  
  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"

  subnets = { # "prod" elasticsearch_configuration requires 3 subnets in different AZ's
    eu-west-1a = "10.0.1.0/24"
  }

  zone_id = "Z06102122M7792QQSFCAD"

  logstash_instance_type = "t2.small"
  
  prometheus_instance_type = "t2.small"
  
  alertmanager_instance_type = "t2.small"
  
  grafana_instance_type = "t2.small"

  elasticsearch_configuration = "staging" # "staging" - 1 t2.small.elasticsearch or "prod" - 3 m5.large.elasticsearch

  # es_days_to_retain = 5
}

output "env" {
  value       = module.calm.env
  description = "The deployment environment"
}

output "logstash_instance_id" {
  value       = module.calm.logstash_instance_id
  description = "Logstash instance ID"
}

output "prometheus_instance_id" {
  value       = module.calm.prometheus_instance_id
  description = "Prometheus instance ID"
}

output "alertmanager_instance_id" {
  value       = module.calm.alertmanager_instance_id
  description = "Alertmanager instance ID"
}

output "grafana_instance_id" {
  value       = module.calm.grafana_instance_id
  description = "Grafana instance ID"
}

output "s3_bucket_name" {
  value       = module.calm.s3_bucket_name
  description = "The name of the S3 bucket"
}

output "elasticsearch_endpoint" {
  value       = module.calm.elasticsearch_endpoint
  description = "The elasticsearch endpoint."
}
