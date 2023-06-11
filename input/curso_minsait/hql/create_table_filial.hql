-- tabela filial hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.filial;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.filial (
    id_filial string,
    ds_filial string,
    id_cidade string
)
COMMENT "Tabela de filial"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.filial LIMIT 10;

-- Tabela filial particionada

DROP TABLE ${TARGET_PRD_DATABASE}.filial;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.filial (
    id_filial string,
    ds_filial string,
    id_cidade string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.filial
PARTITION(DT_FOTO)
SELECT
    id_filial string,
    ds_filial string,
    id_cidade string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.filial;

SELECT * FROM ${TARGET_PRD_DATABASE}.filial LIMIT 10;