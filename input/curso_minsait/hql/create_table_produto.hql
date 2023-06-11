-- tabela produto hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.produto;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.produto (
    id_produto string, 
    ds_produto string, 
    id_subcategoria string
)
COMMENT "Tabela de produto"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.produto LIMIT 10;

-- Tabela produto particionada

DROP TABLE ${TARGET_PRD_DATABASE}.produto;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.produto (
    id_produto string, 
    ds_produto string, 
    id_subcategoria string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.produto
PARTITION(DT_FOTO)
SELECT
    id_produto string, 
    ds_produto string, 
    id_subcategoria string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.produto;

SELECT * FROM ${TARGET_PRD_DATABASE}.produto LIMIT 10;