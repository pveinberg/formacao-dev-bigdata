-- tabela subcategoria hive

DROP TABLE IF EXISTS aula_hive.subcategoria;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.subcategoria (
    id_subcategoria string, 
    ds_subcategoria string, 
    id_categoria string
)
COMMENT "Tabela de subcategoria"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/subcategoria/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.subcategoria LIMIT 10;

-- Tabela subcategoria particionada

DROP TABLE IF EXISTS aula_hive.tbl_subcategoria;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_subcategoria (
    id_subcategoria string, 
    ds_subcategoria string, 
    id_categoria string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_subcategoria LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_subcategoria.hql