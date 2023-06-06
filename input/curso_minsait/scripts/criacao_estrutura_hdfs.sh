#!/bin/bash

# Limpar o terminal
clear 

# Configurar path do arquivo de configuração
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh

# Recuperar as variáveis de configuração
source ${CONFIG}

echo "Iniciando criação da estrutura no HDFS em ${DATE} ..."

echo "Criando base no datalake ..."

hadoop fs -mkdir ${HDFS_BASE_DIR}


echo "Criação de subpastas dentro do datalake ..."
for table in "${TABLES[@]}"
do
    echo "Criando ${table} ..."
    hadoop fs -mkdir ${HDFS_BASE_DIR}/$table
done

hadoop fs -ls ${HDFS_BASE_DIR}