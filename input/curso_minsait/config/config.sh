#! /bin/bash
DATE="$(date --date="-0 day" "+%Y%m%d")"
TABLES=("categoria" "pedido" "cidade" "cliente" "estado" "filial" "item_pedido" "parceiro" "produto" "subcategoria")

TARGET_DATABASE="aula_hive"
SERVER="prod"
HDFS_BASE_DIR="/datalake/raw2"

TARGET_TABLE_EXTERNAL="categoria"
TARGET_TABLE_GERENCIADA="tbl_categoria"

PARTICAO=DATE

