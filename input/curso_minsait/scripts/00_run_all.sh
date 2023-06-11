#!/bin/bash

# Limpar o terminal
clear 

echo "Criando tabelas ..."
bash ./01_download_sources.sh

echo "Copiando arquivos para HDFS..."
bash ./02_copy_to_hdfs.sh

echo "Criando as tabelas no Hive ..."
bash ./03_create_tables.sh
