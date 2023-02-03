resource "grafana_data_source" "testdata_datasource" {
  name = "TestData"
  type = "testdata"
}

resource "grafana_rule_group" "failures_alerts" {
  name             = "Failure alerts"
  folder_uid       = grafana_folder.terraform.uid
  interval_seconds = 60
  org_id           = 1

  rule {
    name      = "My Random Walk Alert"
    condition = "C"
    for       = "0s"

    // Query the datasource.
    data {
      ref_id = "A"
      relative_time_range {
        from = 600
        to   = 0
      }
      datasource_uid = grafana_data_source.testdata_datasource.uid
      // `model` is a JSON blob that sends datasource-specific data.
      // It's different for every datasource. The alert's query is defined here.
      model = jsonencode({
        intervalMs    = 1000
        maxDataPoints = 43200
        refId         = "A"
      })
    }

    // The query was configured to obtain data from the last 60 seconds. Let's alert on the average value of that series using a Reduce stage.
    data {
      datasource_uid = "__expr__"
      // You can also create a rule in the UI, then GET that rule to obtain the JSON.
      // This can be helpful when using more complex reduce expressions.
      model  = <<EOT
{"conditions":[{"evaluator":{"params":[0,0],"type":"gt"},"operator":{"type":"and"},"query":{"params":["A"]},"reducer":{"params":[],"type":"last"},"type":"avg"}],"datasource":{"name":"Expression","type":"__expr__","uid":"__expr__"},"expression":"A","hide":false,"intervalMs":1000,"maxDataPoints":43200,"reducer":"last","refId":"B","type":"reduce"}
EOT
      ref_id = "B"
      relative_time_range {
        from = 0
        to   = 0
      }
    }

    // Now, let's use a math expression as our threshold.
    // We want to alert when the value of stage "B" above exceeds 70.
    data {
      datasource_uid = "__expr__"
      ref_id         = "C"
      relative_time_range {
        from = 0
        to   = 0
      }
      model = jsonencode({
        expression = "$B > 70"
        type       = "math"
        refId      = "C"
      })
    }
  }
}