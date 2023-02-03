resource "grafana_rule_group" "failures_alerts" {
  folder_uid       = "terraform"
  interval_seconds = 60
  name             = "Failures"
  org_id           = 1

  rule {
    annotations = {
      "__dashboardUid__" = "nginx"
      "__panelId__"      = "87"
    }
    condition      = "C"
    exec_err_state = "Error"
    for            = "5m"
    labels         = {}
    name           = "Ingress Non Success Rate (4|5xx responses)"
    no_data_state  = "NoData"

    data {
      datasource_uid = "PBFA97CFB590B2093"
      model = jsonencode(
        {
          datasource = {
            type = "prometheus"
            uid  = "PBFA97CFB590B2093"
          }
          editorMode     = "code"
          expr           = "sum(rate(nginx_ingress_controller_requests{controller_pod=~\".*\",controller_class=~\".*\",namespace=~\".*\",ingress=~\".*\",status=~\"[4-5].*\"}[2m])) by (ingress) / sum(rate(nginx_ingress_controller_requests{controller_pod=~\".*\",controller_class=~\".*\",namespace=~\".*\",ingress=~\".*\"}[2m])) by (ingress)"
          format         = "time_series"
          instant        = false
          interval       = "10s"
          intervalFactor = 1
          intervalMs     = 15000
          legendFormat   = "{{ ingress }}"
          maxDataPoints  = 43200
          metric         = "container_memory_usage:sort_desc"
          refId          = "A"
          step           = 10
        }
      )
      ref_id = "A"

      relative_time_range {
        from = 900
        to   = 0
      }
    }
    data {
      datasource_uid = "-100"
      model = jsonencode(
        {
          conditions = [
            {
              evaluator = {
                params = []
                type   = "gt"
              }
              operator = {
                type = "and"
              }
              query = {
                params = [
                  "B",
                ]
              }
              reducer = {
                params = []
                type   = "last"
              }
              type = "query"
            },
          ]
          datasource = {
            type = "__expr__"
            uid  = "-100"
          }
          expression    = "A"
          hide          = false
          intervalMs    = 1000
          maxDataPoints = 43200
          reducer       = "last"
          refId         = "B"
          settings = {
            mode             = "replaceNN"
            replaceWithValue = 0
          }
          type = "reduce"
        }
      )
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }
    }
    data {
      datasource_uid = "-100"
      model = jsonencode(
        {
          conditions = [
            {
              evaluator = {
                params = [
                  0,
                ]
                type = "gt"
              }
              operator = {
                type = "and"
              }
              query = {
                params = [
                  "C",
                ]
              }
              reducer = {
                params = []
                type   = "last"
              }
              type = "query"
            },
          ]
          datasource = {
            type = "__expr__"
            uid  = "-100"
          }
          expression    = "B"
          hide          = false
          intervalMs    = 1000
          maxDataPoints = 43200
          refId         = "C"
          type          = "threshold"
        }
      )
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }
    }
  }
}