provider "google" {
  credentials = file("ruta/al/archivo-de-credenciales.json")
  project     = "tu-proyecto-de-gcp"
  region      = "us-central1"
}

resource "google_project_iam_member" "writer_permissions" {
  project = "tu-proyecto-de-gcp"
  role    = "roles/bigquery.writer"
  member  = "user:user1"
}

resource "google_project_iam_member" "reader_permissions" {
  project = "tu-proyecto-de-gcp"
  role    = "roles/bigquery.viewer"
  member  = "user:user2"
}
