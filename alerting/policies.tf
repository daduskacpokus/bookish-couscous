resource "grafana_notification_policy" "hpa_policy" {
  group_by      = ["alertname"]
  contact_point = grafana_contact_point.slack_contact_point.name

  group_wait      = "45s"
  group_interval  = "6m"
  repeat_interval = "3h"

  policy {
    matcher {
      label = "ingress"
      match = "="
      value = "hpa-example"
    }
    group_by      = ["..."]
    contact_point = grafana_contact_point.slack_contact_point.name
  }
}