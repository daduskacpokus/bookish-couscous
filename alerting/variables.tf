variable "web_hook" {
  type        = string
  description = "Slack secret"
}

variable "grafana_token" {
  type        = string
  default     = ""
  description = "Grafana secret"
}

variable "grafana_url" {
  type        = string
  default     = ""
  description = "Grafana endpoint"
}
