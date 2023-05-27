-- tabela produto hive

DROP TABLE IF EXISTS aula_hive.produto;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.produto (
    id_produto string, 
    ds_produto string, 
    id_subcategoria string
)
COMMENT "Tabela de produto"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/produto/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.produto LIMIT 10;

-- Tabela produto particionada

DROP TABLE IF EXISTS aula_hive.tbl_produto;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_produto (
    id_produto string, 
    ds_produto string, 
    id_subcategoria string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_produto LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_produto.hql