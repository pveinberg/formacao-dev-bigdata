-- tabela cliente hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.cliente;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.cliente (
    id_cliente string,
    nm_cliente string,
    flag_ouro string
)
COMMENT "Tabela de cliente"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.cliente LIMIT 10;

-- Tabela cliente particionada

DROP TABLE ${TARGET_PRD_DATABASE}.cliente;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.cliente (
    id_cliente string,
    nm_cliente string,
    flag_ouro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.cliente
PARTITION(DT_FOTO)
SELECT
    id_cliente string,
    nm_cliente string,
    flag_ouro string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.cliente;

SELECT * FROM ${TARGET_PRD_DATABASE}.cliente LIMIT 10;