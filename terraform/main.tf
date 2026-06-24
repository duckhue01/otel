terraform {
  required_providers {
    sumologic = {
      source  = "sumologic/sumologic"
      version = "~> 2.30"
    }
  }
}

variable "sumo_access_id" {
  type        = string
  description = "Sumo Logic Access ID"
}

variable "sumo_access_key" {
  type        = string
  description = "Sumo Logic Access Key"
  sensitive   = true
}

variable "sumo_environment" {
  type        = string
  description = "Sumo Logic Environment (e.g. us1, us2, eu, au)"
  default     = "au"
}

provider "sumologic" {
  access_id   = var.sumo_access_id
  access_key  = var.sumo_access_key
  environment = var.sumo_environment
}

resource "sumologic_collector" "gateway" {
  name        = "dev-monitoring-gateway"
  description = "Self-managed OTel Gateway Collector"
}

resource "sumologic_http_source" "logs" {
  name         = "otel-logs"
  collector_id = sumologic_collector.gateway.id
  description  = "HTTP source for OTLP logs from the OTel Gateway"
  message_per_request = false
}

output "http_source_url" {
  value       = sumologic_http_source.logs.url
  sensitive   = true
  description = "The HTTP endpoint URL to configure in the sumologic exporter"
}
