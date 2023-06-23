#! /bin/bash
# reading source
source <(grep = vars.ini)
for n in "${names[@]}"
do
    echo $n
done

echo "${name} [${mail}]"

echo $DATE
echo $PARTICAO

echo ${MEU_MAIL}