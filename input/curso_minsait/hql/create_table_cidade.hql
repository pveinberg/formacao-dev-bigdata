-- tabela cidade hive

DROP TABLE IF EXISTS aula_hive.cidade;

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.cidade (
    id_cidade string,
    ds_cidade string,
    id_estado string
)
COMMENT "Tabela de cidade"
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "|"
STORED AS TEXTFILE
location  '/datalake/raw/cidade/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM aula_hive.cidade LIMIT 10;

-- Tabela cidade particionada

DROP TABLE IF EXISTS aula_hive.tbl_cidade;

CREATE TABLE IF NOT EXISTS aula_hive.tbl_cidade (
    id_cidade string,
    ds_cidade string,
    id_estado string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SELECT * FROM aula_hive.tbl_cidade LIMIT 10;

-- beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_cidade.hql