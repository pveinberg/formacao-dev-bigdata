-- tabela categoria hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.categoria;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.categoria (
    id_categoria string,
    ds_categoria string,
    perc_parceiro string
)
COMMENT "Tabela de Categoria"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.categoria LIMIT 10;

-- Tabela categoria particionada

DROP TABLE ${TARGET_PRD_DATABASE}.categoria;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.categoria (
    id_categoria string,
    ds_categoria string,
    perc_parceiro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.categoria
PARTITION(DT_FOTO)
SELECT
    id_categoria string,
    ds_categoria string,
    perc_parceiro string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.categoria;

SELECT * FROM ${TARGET_PRD_DATABASE}.categoria LIMIT 10;
