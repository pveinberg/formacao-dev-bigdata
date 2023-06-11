-- tabela item_pedido hive

CREATE DATABASE IF NOT EXISTS ${TARGET_STAGE_DATABASE}; 
CREATE DATABASE IF NOT EXISTS ${TARGET_PRD_DATABASE};

DROP TABLE ${TARGET_STAGE_DATABASE}.item_pedido;

CREATE EXTERNAL TABLE IF NOT EXISTS ${TARGET_STAGE_DATABASE}.item_pedido (
    id_pedido string,
    id_produto string,
    quantidade string,
    vr_unitario string
)
COMMENT "Tabela de item_pedido"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  "${HDFS_DIR}"
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM ${TARGET_STAGE_DATABASE}.item_pedido LIMIT 10;

-- Tabela item_pedido particionada

DROP TABLE ${TARGET_PRD_DATABASE}.item_pedido;

CREATE TABLE IF NOT EXISTS ${TARGET_PRD_DATABASE}.item_pedido (
    id_pedido string,
    id_produto string,
    quantidade string,
    vr_unitario string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE 
    ${TARGET_PRD_DATABASE}.item_pedido
PARTITION(DT_FOTO)
SELECT
    id_pedido string,
    id_produto string,
    quantidade string,
    vr_unitario string,
    '${PARTICAO}' as DT_FOTO
FROM ${TARGET_STAGE_DATABASE}.item_pedido;

SELECT * FROM ${TARGET_PRD_DATABASE}.item_pedido LIMIT 10;