resource "grafana_dashboard" "nginx_errors" {

  for_each    = fileset("${path.module}/dashboards", "*.json")
  config_json = file("${path.module}/dashboards/${each.key}")
  folder      = grafana_folder.terraform.id
}