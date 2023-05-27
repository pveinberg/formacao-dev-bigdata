-- tabela filial hive

DROP TABLE IF EXISTS aula_hive.filial;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.filial (
    id_filial string,
    ds_filial string,
    id_cidade string
)
COMMENT "Tabela de filial"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/filial/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.filial LIMIT 10;

-- Tabela filial particionada

DROP TABLE IF EXISTS aula_hive.tbl_filial;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_filial (
    id_filial string,
    ds_filial string,
    id_cidade string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_filial LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_filial.hql