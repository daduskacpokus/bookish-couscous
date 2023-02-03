terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.28.2"
    }
  }
}

provider "grafana" {
  url  = "http://a54a40c5114d84eb880870b8f7939450-1264209402.us-east-1.elb.amazonaws.com/grafana/api/dashboards/home"
  auth = var.token
}