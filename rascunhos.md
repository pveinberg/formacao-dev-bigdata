# Roadmap

## Donwload de source

Baixar arquivos (curl) do repositório (*) 

(*) O arquivo de pedidos já deve estar no ambiente pq é muito grande

## Mover o conteúdo 
Mover o conteúdo que foi baixado para *hdfs*


--------------

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


df_categoria = spark.sql("select * from aula_hive.categoria")
df_cidade = spark.sql("select * from aula_hive.cidade")
df_cliente = spark.sql("select * from aula_hive.cliente")
df_estado = spark.sql("select * from aula_hive.estado")
df_filial = spark.sql("select * from aula_hive.filial")
df_tem_pedido = spark.sql("select * from aula_hive.tem_pedido")
df_parceiro = spark.sql("select * from aula_hive.parceiro")
df_pedido = spark.sql("select * from aula_hive.pedido")
df_produto = spark.sql("select * from aula_hive.produto")
df_subcategoria = spark.sql("select * from aula_hive.subcategoria")


pedidos_full['dt_ano'] = pedidos_full['dt_pedido'].dt.year
pedidos_full['dt_mes'] = pedidos_full['dt_pedido'].dt.month
pedidos_full['dt_dia_semana'] = pedidos_full['dt_pedido'].dt.dayofweek
pedidos_full['dt_trimestre'] = pedidos_full['dt_pedido'].dt.quarter
pedidos_full['dt_trimestre'] = pedidos_full['dt_pedido'].dt.quarter
pedidos_full['dt_semana'] = pedidos_full['dt_pedido'].dt.week
pedidos_full


docker exec 5f060f3b7774 hdfs dfs -ls /



# categoria
# subcategoria
# filial
# cidade
# estado
# cliente
# parceiro
# produto
# item_pedido
# pedido


{
"categoria": {
        "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"subcategoria": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"filial": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"cidade": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"estado": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"cliente": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"parceiro": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"produto": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"item_pedido": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
},
"pedido": {
    "fields": {
        "float": [], 
        "datetime64[ns]": ["dt_foto"] 
    }
}
}