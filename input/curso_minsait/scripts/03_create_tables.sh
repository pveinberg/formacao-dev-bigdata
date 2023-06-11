#! /bin/bash

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh
source ${CONFIG}

for table in "${TABLES[@]}"
do    

echo "Creando [${table}] ..."
docker exec ${DOCKER_HIVE_ID} beeline -u jdbc:hive2://localhost:10000 \
--hivevar TARGET_STAGE_DATABASE=${TARGET_STAGE_DATABASE} \
--hivevar TARGET_PRD_DATABASE=${TARGET_PRD_DATABASE} \
--hivevar HDFS_DIR=/datalake/${RAW_BASE_DIR}/${table} \
--hivevar TARGET_TABLE=${table} \
--hivevar PARTICAO=${PARTICAO} \
-f ${BASE_NAMENODE_DIR}/hql/create_table_${table}.hql

done

echo "Fim do processo ..."