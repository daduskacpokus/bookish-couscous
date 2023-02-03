resource "grafana_contact_point" "slack_contact_point" {
  name = "Send to My Slack Channel"

  slack {
    url  = var.web_hook
    text = <<EOT
{{ len .Alerts.Firing }} alerts are firing!

Alert summaries:
{{ range .Alerts.Firing }}
{{ template "Alert Instance Template" . }}
{{ end }}
EOT
  }
}