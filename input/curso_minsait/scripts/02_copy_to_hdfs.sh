#! /bin/bash

# Configurar path do arquivo de configuração
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh

# Recuperar as variáveis de configuração
source ${CONFIG}

echo ">> Iniciando a criacao em ${DATE} ... "
NEW_FOLDER="${BASEDIR}/../${RAW_BASE_DIR}"

# -------------------------------------------------------------------------------
# Limpando ambiente para conseguir testar
# EXCLUIR ESTE CÓDIGO ANTES DE PUBLICAR
docker exec ${DOCKER_HDFS_ID} hdfs dfs -rm -r -f /datalake/${RAW_BASE_DIR}
docker exec ${DOCKER_HDFS_ID} hdfs dfs -rm -r -f /datalake/${SILVER_BASE_DIR}
docker exec ${DOCKER_HDFS_ID} hdfs dfs -rm -r -f /datalake/${GOLD_BASE_DIR}
# -------------------------------------------------------------------------------


for table in "${TABLES[@]}"
do    

    echo "Criando diretórios no datalake [${table}] ..."

    docker exec ${DOCKER_HDFS_ID} hdfs dfs -mkdir -p /datalake/${RAW_BASE_DIR}/$table
    docker exec ${DOCKER_HDFS_ID} hdfs dfs -mkdir -p /datalake/${SILVER_BASE_DIR}/$table
    docker exec ${DOCKER_HDFS_ID} hdfs dfs -mkdir -p /datalake/${GOLD_BASE_DIR}/$table

    echo "Outorgando permissões no datalake [${table}] ..."

    docker exec ${DOCKER_HDFS_ID} hdfs dfs -chmod 777 /datalake/${RAW_BASE_DIR}/$table
    docker exec ${DOCKER_HDFS_ID} hdfs dfs -chmod 777 /datalake/${SILVER_BASE_DIR}/$table
    docker exec ${DOCKER_HDFS_ID} hdfs dfs -chmod 777 /datalake/${GOLD_BASE_DIR}/$table

    echo "Copiando arquivo para HDFS (apenas para a pasta raw) [${table}] ..."
    FROM_DIR="${BASE_NAMENODE_DIR}/${RAW_BASE_DIR}/${table}/${table}.csv"
    TO_DIR="/datalake/${RAW_BASE_DIR}/${table}"
    
    echo "FROM: ${FROM_DIR}"
    echo "TO: ${TO_DIR}"
    
    # docker exec ${DOCKER_HDFS_ID} chmod 777 $FROM_DIR
    docker exec ${DOCKER_HDFS_ID} hdfs dfs -copyFromLocal $FROM_DIR $TO_DIR 

    echo " - -  - -  - -  - -  - -  - -  - -  - -  - -  - -  - -  - -  - -  - - "
done

echo "Fim do processo ..."