#! /bin/bash
DATE="$(date --date="-0 day" "+%Y%m%d")"
TABLES=("categoria" "pedido" "cidade" "cliente" "estado" "filial" "item_pedido" "parceiro" "produto" "subcategoria")
TARGET_DATABASE="aula_hive"