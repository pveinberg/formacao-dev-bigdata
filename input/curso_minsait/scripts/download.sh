#!/bin/bash

cd ./../raw

mkdir categorias

cd categorias

# curl -O 'https://github.com/caiuafranca/dados_curso/blob/main/categoria.csv'
wget -O 'https://github.com/caiuafranca/dados_curso/blob/main/'

# baixar todos os arquivos
# pode ser feito com python
# julio neves, shell script