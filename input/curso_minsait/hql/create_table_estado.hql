-- tabela estado hive

DROP TABLE IF EXISTS aula_hive.estado;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.estado (
    id_estado string,
    ds_estado string
)
COMMENT "Tabela de estado"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/estado/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.estado LIMIT 10;

-- Tabela estado particionada

DROP TABLE IF EXISTS aula_hive.tbl_estado;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_estado (
    id_estado string,
    ds_estado string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_estado LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_estado.hql