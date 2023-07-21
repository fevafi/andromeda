resource "google_bigquery_routine" "rutine_id" {
  dataset_id       = "datasetG"
  routine_id       = "rutine_id"
  language         = "SQL"
  type             = "PROCEDURE"
  definition_body  = <<EOF_SQL
select a as d, b, c from dataset.tabla2;
EOF_SQL
}
