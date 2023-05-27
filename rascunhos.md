### Criando pastas dentro do hdfs

```
hdfs dfs -mkdir /datalake/raw/categoria && hdfs dfs -mkdir /datalake/raw/alunos && hdfs dfs -mkdir /datalake/raw/cidade && hdfs dfs -mkdir /datalake/raw/cliente && hdfs dfs -mkdir /datalake/raw/estado && hdfs dfs -mkdir /datalake/raw/filial && hdfs dfs -mkdir /datalake/raw/item_pedido && hdfs dfs -mkdir /datalake/raw/parceiro && hdfs dfs -mkdir /datalake/raw/produto && hdfs dfs -mkdir /datalake/raw/subcategoria
```

hdfs dfs -mkdir /datalake/raw/categoria 

hdfs dfs -copyFromLocal ./alunos/alunos.csv /datalake/raw/alunos

hdfs dfs -copyFromLocal ./cidade/cidade.csv /datalake/raw/cidade && hdfs dfs -copyFromLocal ./cliente/cliente.csv /datalake/raw/cliente && hdfs dfs -copyFromLocal ./estado/estado.csv /datalake/raw/estado && hdfs dfs -copyFromLocal ./filial/filial.csv /datalake/raw/filial && hdfs dfs -copyFromLocal ./item_pedido/item_pedido.csv /datalake/raw/item_pedido && hdfs dfs -copyFromLocal ./parceiro/parceiro.csv /datalake/raw/parceiro && hdfs dfs -copyFromLocal ./produto/produto.csv /datalake/raw/produto && hdfs dfs -copyFromLocal ./subcategoria/subcategoria.csv /datalake/raw/subcategoria && hdfs dfs -copyFromLocal ./pedido/pedido.csv /datalake/raw/pedido

### Criacao de tabela no hive

CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.categoria (
    id_categoria string,
    ds_categoria string,
    perc_parceiro string
)
COMMENT 'Tabela de Categoria'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location  '/datalake/raw/categoria/'
TBLPROPERTIES ("skip.header.line.count"="1");


### Criacao de tabela particionada

CREATE TABLE aula_hive.tbl_categoria (
    id_categoria string,
    ds_categoria string,
    perc_parceiro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');


beeline -u jdbc:hive2://localhost:10000 -f  /input/curso_minsait/hql/create_table_categoria.hql