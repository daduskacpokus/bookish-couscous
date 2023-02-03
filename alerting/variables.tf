variable "web_hook" {
  type        = string
  description = "Slack secret"
}

variable "token" {
  type        = string
  default     = ""
  description = "Grafana secret"
}
