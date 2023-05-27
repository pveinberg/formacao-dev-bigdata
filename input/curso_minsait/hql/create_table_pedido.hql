-- tabela pedido hive

DROP TABLE IF EXISTS aula_hive.pedido;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.pedido (
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
location  '/datalake/raw/pedido/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.pedido LIMIT 10;

-- Tabela pedido particionada

DROP TABLE IF EXISTS aula_hive.tbl_pedido;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_pedido (
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

SELECT * FROM aula_hive.tbl_pedido LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_pedido.hql