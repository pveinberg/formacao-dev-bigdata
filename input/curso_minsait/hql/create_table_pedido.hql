-- tabela pedido hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.pedido;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.pedido (
    id_pedido string, 
    dt_pedido string, 
    id_parceiro string, 
    id_cliente string, 
    id_filial string, 
    vr_total_pago string
)
COMMENT "Tabela de pedido"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.pedido LIMIT 10;

-- Tabela pedido particionada

DROP TABLE ${TARGET_PRD_DATABASE}.pedido;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.pedido (
    id_pedido string, 
    dt_pedido string, 
    id_parceiro string, 
    id_cliente string, 
    id_filial string, 
    vr_total_pago string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.pedido
PARTITION(DT_FOTO)
SELECT
    id_pedido string, 
    dt_pedido string, 
    id_parceiro string, 
    id_cliente string, 
    id_filial string, 
    vr_total_pago string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.pedido;

SELECT * FROM ${TARGET_PRD_DATABASE}.pedido LIMIT 10;