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
  source = "git@gitlab.com:simply-calm/terraform-module.git" #?ref=v1.4
  
  name = "calm"

  env = "staging"
  
  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"

  subnets = { # elasticsearch configuration with more than 1 node requires 3 subnets in different AZ's
    eu-west-1a = "10.0.1.0/24"
  }

  zone_id = "Z06102122M7792QQSFCAD"

  # EC2 Config ####################

  logstash_instance_type = "t2.small"
  logstash_storage_size = 10
  
  prometheus_instance_type = "t2.small"
  prometheus_storage_size = 10
  
  alertmanager_instance_type = "t2.small"
  alertmanager_storage_size = 10
  
  grafana_instance_type = "t2.small"
  grafana_storage_size = 10

  # Elasticsearch Config ####################

  # TESTING ##
  es_data_instance_type = "t2.small.elasticsearch"
  es_data_node_count = 1
  
  ebs_volume_size = 10

  es_rest_encryption = false # defaults true (can't be used with t2.small)
  es_node2node_encryption = false # defaults true (can't be used with t2.small)

  # es_days_to_retain = 5
}

output "env" {
  value       = module.calm.env
  description = "The deployment environment"
}

output "region" {
  value       = module.calm.region
  description = "The deployment region"
}

output "name" {
  value       = module.calm.name
  description = "The name of deployment"
}

output "logstash_instance_id" {
  value       = module.calm.logstash_instance_id
  description = "Logstash instance ID"
}

output "logstash_instance_ip" {
  value       = module.calm.logstash_instance_ip
  description = "Logstash instance IP"
}

output "prometheus_instance_id" {
  value       = module.calm.prometheus_instance_id
  description = "Prometheus instance ID"
}

output "prometheus_instance_ip" {
  value       = module.calm.prometheus_instance_ip
  description = "Prometheus instance IP"
}

output "alertmanager_instance_id" {
  value       = module.calm.alertmanager_instance_id
  description = "Alertmanager instance ID"
}

output "alertmanager_instance_ip" {
  value       = module.calm.alertmanager_instance_ip
  description = "Alertmanager instance IP"
}

output "grafana_instance_id" {
  value       = module.calm.grafana_instance_id
  description = "Grafana instance ID"
}

output "grafana_instance_ip" {
  value       = module.calm.grafana_instance_ip
  description = "Grafana instance IP"
}

output "s3_bucket_name" {
  value       = module.calm.s3_bucket_name
  description = "The name of the S3 bucket"
}

output "elasticsearch_endpoint" {
  value       = module.calm.elasticsearch_endpoint
  description = "The elasticsearch endpoint."
}
