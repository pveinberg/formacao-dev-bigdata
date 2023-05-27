-- tabela item_pedido hive

DROP TABLE IF EXISTS aula_hive.item_pedido;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.item_pedido (
    id_pedido stirng,
    id_produto string,
    quantidade string,
    vr_unitario string
)
COMMENT "Tabela de item_pedido"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/item_pedido/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.item_pedido LIMIT 10;

-- Tabela item_pedido particionada

DROP TABLE IF EXISTS aula_hive.tbl_item_pedido;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_item_pedido (
    id_pedido stirng,
    id_produto string,
    quantidade string,
    vr_unitario string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_item_pedido LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_item_pedido.hql