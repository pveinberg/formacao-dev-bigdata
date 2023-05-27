#! /bin/bash

clear 

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh
source ${CONFIG}

echo "Iniciando a criacao de tabelas em ${DATE}"

for table in "${TABLES[@]}"
do
    echo "TABELA: $table"
    beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_${table}.hql
done
