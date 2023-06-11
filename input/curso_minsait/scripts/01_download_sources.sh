#! /bin/bash

# Configurar path do arquivo de configuração
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )
CONFIG=${BASEDIR}/../config/config.sh

# Recuperar as variáveis de configuração
source ${CONFIG}

echo ">> Iniciando a criacao em ${DATE} ... "

NEW_FOLDER="${BASEDIR}/../${RAW_BASE_DIR}"

echo ">> Criando ${NEW_FOLDER}"
mkdir -p $NEW_FOLDER

# Iterando as tabelas que serão recuperadas. 
# Para cada tabela deverá ser criado um diretório e cada arquivo será descargado da fonte para este diretório
for table in "${TABLES[@]}"
do
    
    # Acessando o diretório raw (base)
    cd ${NEW_FOLDER}

    # Descarregando o arquivo da fonte
    if [[ ${table} != "pedido" ]]
    then
        # Criando o diretório com o nome da tabela
        mkdir $table

        # Acessando o diretório
        cd $table
     
        echo "Donwloading ${table} from repo..."
        curl -O https://raw.githubusercontent.com/caiuafranca/dados_curso/main/${table}.csv
    else
        echo "Unzipping pedidos.zip"
        chmod 777 ${BASEDIR}/../${RAW_BASE_DIR} 
        unzip ${BASEDIR}/../../material/pedido.zip -d ${BASEDIR}/../${RAW_BASE_DIR}
    fi

done

echo "Fim do processo..."