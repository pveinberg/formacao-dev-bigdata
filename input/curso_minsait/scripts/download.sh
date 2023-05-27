#! /bin/bash

clear 

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh
source ${CONFIG}

echo "Iniciando a criacao em ${DATE}"


for table in "${TABLES[@]}"
do
    echo "TABELA: $table"
    cd ./../raw/
    mkdir $table
    cd $table
    curl -O https://raw.githubusercontent.com/caiuafranca/dados_curso/main/${table}.csv
    cd ..

done
