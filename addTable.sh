#!/bin/bash

# Definición de la función file() para imprimir el contenido del archivo
file() {
  local content
  if content=$(<"$1"); then
    echo "$content"
  else
    echo "Archivo no encontrado: $1"
  fi
}

# Verificar los argumentos de entrada
if [[ $# -lt 6 ]]; then
  echo "Uso: $0 <nombre_archivo_tf> <dataset> <tabla> <vista> <ruta_schema_avro> <ruta_sql_vista>"
  exit 1
fi

# Asignar los argumentos a variables
nombre_archivo_tf=$1
dataset=$2
tabla=$3
vista=$4
ruta_schema_avro=$5
ruta_sql_vista=$6

# Crear archivo de configuración de Terraform
cat <<EOF > "${nombre_archivo_tf}"
provider "google" {
  credentials = file("ruta/al/archivo-de-credenciales.json")
  project     = "tu-proyecto-de-gcp"
  region      = "us-central1"
}

resource "google_bigquery_dataset" "example_dataset" {
  dataset_id = "${dataset}"
}

resource "google_bigquery_table" "example_table" {
  dataset_id = google_bigquery_dataset.example_dataset.dataset_id
  table_id   = "${tabla}"

  schema {
    avro_schema = <<EOF_AVRO
$(file "${ruta_schema_avro}")
EOF_AVRO
  }
}

resource "google_bigquery_table" "example_view" {
  dataset_id = google_bigquery_dataset.example_dataset.dataset_id
  table_id   = "${vista}"

  view {
    query = <<EOF_SQL
$(file "${ruta_sql_vista}")
EOF_SQL
  }
}
EOF

echo "Archivo de configuración de Terraform generado: ${nombre_archivo_tf}"
