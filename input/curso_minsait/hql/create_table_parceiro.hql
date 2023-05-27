-- tabela parceiro hive

DROP TABLE IF EXISTS aula_hive.parceiro;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.parceiro (
    id_parceiro string, 
    nm_parceiro string
)
COMMENT "Tabela de parceiro"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/parceiro/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.parceiro LIMIT 10;

-- Tabela parceiro particionada

DROP TABLE IF EXISTS aula_hive.tbl_parceiro;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_parceiro (
    id_parceiro string, 
    nm_parceiro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_parceiro LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_parceiro.hql