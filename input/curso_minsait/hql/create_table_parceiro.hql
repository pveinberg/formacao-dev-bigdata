-- tabela parceiro hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.parceiro;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.parceiro (
    id_parceiro string, 
    nm_parceiro string
)
COMMENT "Tabela de parceiro"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.parceiro LIMIT 10;

-- Tabela parceiro particionada

DROP TABLE ${TARGET_PRD_DATABASE}.parceiro;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.parceiro (
    id_parceiro string, 
    nm_parceiro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.parceiro
PARTITION(DT_FOTO)
SELECT
    id_parceiro string, 
    nm_parceiro string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.parceiro;

SELECT * FROM ${TARGET_PRD_DATABASE}.parceiro LIMIT 10;