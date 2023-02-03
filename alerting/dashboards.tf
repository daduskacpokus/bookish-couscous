resource "grafana_dashboard" "nginx_errors" {

  config_json = file("${path.module}/dashboards/nginx-ingress-controller-1675448635888.json")
  folder      = grafana_folder.terraform.id
}