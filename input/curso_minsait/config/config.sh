#!/bin/bash

DATE = "$(date --date="-0 day" "+%Y%m%d")"

TABLES = ("alunos", "categorias", "cidade", "cliente", "estado", "filial", "item_pedido", "parceiro", "pedido", "produto", "subcategoria")

TARGET_DATABASE = "aula_hive"
