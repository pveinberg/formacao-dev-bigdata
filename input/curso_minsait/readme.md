# Curso Minsait

* scripts: todos os scrips que iremos criar
* raw: simlar um ambiente onde serão recebidos arquivos
* gold: ?
* app: será criado um power BI para relatórios


entender o que fato e dimensão
transformar relacional >> dimensional (foco na performance para demandas analíticas - tomada de decição -KPI, atrelados a metas)
>> utilizarndo pyspark


MODELO DIMENSIONAL

* pode ser considerado o complemento de um modelo físico
* modelo dimensional: 2 modelos snowflake, starmodel
* FATO: tabela que carrega apenas as chaves e as métricas construídas na tabela fato
* DIMENSAO: descrições das informações

Roteiro:
1. identificar as entidades
2. compor as dimensões
3. definir hierarquias, por exemplo data, mes, trimestre, semestre, semana, etc/ ou genrente secção, gerente regional, etc
4. criar as chaves de dimensão, são diferentes das chaves do relacional
5. identificar os indicadores de negócio (com as métricas de composição)
6. construir a tabela fato
7. configurar os agregados (fatos com granularidade maios)
8. testar e otimizar

https://cwiki.apache.org/confluence/collector/pages.action?key=Hive

## Query SQOOP
sqoop eval --connect jdbc:mysql://database/employees --username=root --password=secret --query "SELECT * FROM employees limit 15"