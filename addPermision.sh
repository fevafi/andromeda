#!/bin/bash

# Verificar los argumentos de entrada
if [[ $# -lt 3 ]]; then
  echo "Uso: $0 <nombre_archivo_tf> <usuario_escritor> <usuario_lector>"
  exit 1
fi

# Asignar los argumentos a variables
nombre_archivo_tf=$1
usuario_escritor=$2
usuario_lector=$3

# Generar el archivo de script de Terraform
cat <<EOF > "${nombre_archivo_tf}.tf"
provider "google" {
  credentials = file("ruta/al/archivo-de-credenciales.json")
  project     = "tu-proyecto-de-gcp"
  region      = "us-central1"
}

resource "google_project_iam_member" "writer_permissions" {
  project = "tu-proyecto-de-gcp"
  role    = "roles/bigquery.dataEditor"
  member  = "user:${usuario_escritor}"
}

resource "google_project_iam_member" "reader_permissions" {
  project = "tu-proyecto-de-gcp"
  role    = "roles/bigquery.dataViewer"
  member  = "user:${usuario_lector}"
}
EOF

echo "Archivo de script de Terraform generado: ${nombre_archivo_tf}.tf"
