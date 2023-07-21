#!/bin/bash

# Verificar los argumentos de entrada
if [[ $# -lt 4 ]]; then
  echo "Uso: $0 <nombre_archivo_tf> <dataset> <routine_id> <ruta_sql_procedure>"
  exit 1
fi

# Asignar los argumentos a variables
nombre_archivo_tf=$1
dataset=$2
routine_id=$3
ruta_sql_procedure=$4

# Leer el contenido del archivo SQL
sql_procedure=$(cat "${ruta_sql_procedure}")

# Generar el archivo de script de Terraform
cat <<EOF > "${nombre_archivo_tf}.tf"
resource "google_bigquery_routine" "${routine_id}" {
  dataset_id       = "${dataset}"
  routine_id       = "${routine_id}"
  language         = "SQL"
  type             = "PROCEDURE"
  definition_body  = <<EOF_SQL
${sql_procedure}
EOF_SQL
}
EOF

echo "Archivo de script de Terraform generado: ${nombre_archivo_tf}.tf"
