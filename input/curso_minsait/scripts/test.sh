#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$BASEDIR/../config/config.sh"
source="${CONFIG}"

for table in "${TABLES[@]}":
do
    echo $table
done