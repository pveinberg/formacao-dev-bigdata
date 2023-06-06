#! /bin/bash

clear 

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh
source ${CONFIG}

echo "Iniciando a criacao em ${DATE}"

for table in "${TABLES[@]}"
do
    echo "Copiando ${table}.csv"
    cd "./../raw/$table/"
    
    pwd
    
    hdfs dfs -chmod 777 ${HDFS_BASE_DIR}/${table}
    hdfs dfs -copyFromLocal $table.csv ${HDFS_BASE_DIR}/${table}
    
    cd ..

done

echo "Fim do processo ..."
