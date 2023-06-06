#! /bin/bash

# Limpar o terminal
clear 

# Configurar path do arquivo de configuração
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh

# Recuperar as variáveis de configuração
source ${CONFIG}

echo "Iniciando a criacao em ${DATE}"

# Iterando as tabelas que serão recuperadas. 
# Para cada tabela deverá ser criado um diretório e cada arquivo será descargado da fonte para este diretório
for table in "${TABLES[@]}"
do
    echo "Downloading ${table}.csv"
    
    # Acessando o diretório raw (base)
    cd ./../raw/

    # Criando o diretório com o nome da tabela
    mkdir $table

    # Acessando o diretório
    cd $table

    # Descarregando o arquivo da fonte
    curl -O https://raw.githubusercontent.com/caiuafranca/dados_curso/main/${table}.csv

    # Voltando ao diretório raiz (raw)
    cd ..

done

# (*) O arquivo zipado (pedido.zip) não está no repo para ser descarregado,
# será preciso copiá-lo do filesystem local e descomprimi-lo no diretório correto
# o arquivo zip tem a estrutura seguinte: "pedido/pedido.csv"

# Descomprimento o arquivo 
unzip pedido.zip

# Removendo o arquivo zipado 
rm pedido.zip

echo "Fim do processo..."
