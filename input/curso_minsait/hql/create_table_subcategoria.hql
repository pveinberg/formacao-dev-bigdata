-- tabela subcategoria hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.subcategoria;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.subcategoria (
    id_subcategoria string, 
    ds_subcategoria string, 
    id_categoria string
)
COMMENT "Tabela de Subcategoria"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.subcategoria LIMIT 10;

-- Tabela subcategoria particionada

DROP TABLE ${TARGET_PRD_DATABASE}.subcategoria;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.subcategoria (
    id_subcategoria string, 
    ds_subcategoria string, 
    id_categoria string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.subcategoria
PARTITION(DT_FOTO)
SELECT
    id_subcategoria string, 
    ds_subcategoria string, 
    id_categoria string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.subcategoria;

SELECT * FROM ${TARGET_PRD_DATABASE}.subcategoria LIMIT 10;