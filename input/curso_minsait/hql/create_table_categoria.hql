-- tabela categoria hive

DROP TABLE aula_hive.categoria;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.categoria (
    id_categoria string,
    ds_categoria string,
    perc_parceiro string
)
COMMENT "Tabela de Categoria"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/categoria/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.categoria LIMIT 10;

-- Tabela categoria particionada

DROP TABLE aula_hive.tbl_categoria;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_categoria (
    id_categoria string,
    ds_categoria string,
    perc_parceiro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_categoria.hql