-- tabela cliente hive

DROP TABLE IF EXISTS aula_hive.cliente;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.cliente (
    id_cliente string,
    nm_cliente string,
    flag_ouro string
)
COMMENT "Tabela de cliente"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/cliente/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.cliente LIMIT 10;

-- Tabela cliente particionada

DROP TABLE IF EXISTS aula_hive.tbl_cliente;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_cliente (
    id_cliente string,
    nm_cliente string,
    flag_ouro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_cliente LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_cliente.hql