#! /bin/bash

# Data atual
DATE="$(date --date="-0 day" "+%Y%m%d")"

# Tabelas/arquivos que fazem parte do domínio do projeto
# (*) a entidade 'pedido' tem um tratamento diferenciado, já que não se encontra no repositório
TABLES=("categoria" "subcategoria" "filial" "cidade" "estado" "cliente" "parceiro" "produto" "item_pedido" "pedido")

# Base de dados
TARGET_STAGE_DATABASE="stg_magalu_db"
TARGET_PRD_DATABASE="prd_magalu_db"

# Diretório base do projeto
BASE_DIR="magalu_project"

# Diretórios de trabalho
RAW_BASE_DIR="${BASE_DIR}/raw"
SILVER_BASE_DIR="${BASE_DIR}/silver"
GOLD_BASE_DIR="${BASE_DIR}/gold"

# namenode ID
DOCKER_HDFS_ID="namenode"
BASE_NAMENODE_DIR="/input/curso_minsait" 

# hive-server ID
DOCKER_HIVE_ID="hive-server"

TARGET_TABLE_EXTERNAL="categoria"
TARGET_TABLE_GERENCIADA="tbl_categoria"

PARTICAO=${DATE}