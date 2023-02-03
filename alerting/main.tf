terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.28.2"
    }
  }
  backend "s3" {
    key    = "alerting.tfstate"
    region = "eu-central-1"
  }
}
provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_token
}