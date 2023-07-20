provider "google" {
  credentials = file("ruta/al/archivo-de-credenciales.json")
  project     = "tu-proyecto-de-gcp"
  region      = "us-central1"
}

resource "google_bigquery_dataset" "example_dataset" {
  dataset_id = "atomo"
}

resource "google_bigquery_table" "example_table" {
  dataset_id = google_bigquery_dataset.example_dataset.dataset_id
  table_id   = "molecula"

  schema {
    avro_schema = file("def.yaml")
  }
}

resource "google_bigquery_table" "example_view" {
  dataset_id = google_bigquery_dataset.example_dataset.dataset_id
  table_id   = "tejido"

  view {
    query = file("query.sql")
  }
}
