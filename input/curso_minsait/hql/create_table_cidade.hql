-- tabela cidade hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.cidade;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.cidade (
    id_cidade string,
    ds_cidade string,
    id_estado string
)
COMMENT "Tabela de cidade"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.cidade LIMIT 10;

-- Tabela cidade particionada

DROP TABLE ${TARGET_PRD_DATABASE}.cidade;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.cidade (
    id_cidade string,
    ds_cidade string,
    id_estado string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.cidade
PARTITION(DT_FOTO)
SELECT
    id_cidade string,
    ds_cidade string,
    id_estado string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.cidade;

SELECT * FROM ${TARGET_PRD_DATABASE}.cidade LIMIT 10;