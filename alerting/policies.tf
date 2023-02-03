resource "grafana_notification_policy" "my_policy" {
  group_by      = ["alertname"]
  contact_point = grafana_contact_point.my_slack_contact_point.name

  group_wait      = "45s"
  group_interval  = "6m"
  repeat_interval = "3h"

  policy {
    matcher {
      label = "nginx"
      match = "="
      value = "errors"
    }
    group_by      = ["..."]
    contact_point = grafana_contact_point.my_slack_contact_point.name
  }
}