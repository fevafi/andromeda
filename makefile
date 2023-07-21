.DEFAULT_GOAL := help

.PHONY: add_table help

add_table: 
	@./addTable.sh $(ARGS)

.PHONY: auth

auth: 
	@./addPermision.sh $(ARGS)

.PHONY: procedure

procedure: 
	@./addProcedure.sh $(ARGS)

.PHONY: help
help:
	@echo "Uso: make add_table ARGS='<nombre_archivo_tf> <dataset> <tabla> <vista> <ruta_schema_avro> <ruta_sql_vista>'"
	@echo ""
	@echo "Descripción:"
	@echo "  Genera un archivo de configuración de Terraform para desplegar una tabla y una vista en BigQuery."
	@echo ""
	@echo "Parámetros:"
	@echo "  nombre_archivo_tf  Nombre del archivo de configuración de Terraform a generar (formato .tf)"
	@echo "  dataset            Nombre del dataset en BigQuery"
	@echo "  tabla              Nombre de la tabla en BigQuery"
	@echo "  vista              Nombre de la vista en BigQuery"
	@echo "  ruta_schema_avro   Ruta al archivo que contiene la definición del schema de la tabla en formato Avro"
	@echo "  ruta_sql_vista     Ruta al archivo que contiene el SQL para definir la vista"
