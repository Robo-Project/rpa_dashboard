#!/bin/bash
set -o allexport;
source environment/grafana.env;
source environment/paths.env;
set +o allexport

mkdir -p $DS_PATH && curl -s "http://localhost:3000/api/datasources"  -u $GF_USER:$GF_PASSWORD|jq -c -M '.[]'|split -l 1 - $DS_PATH

mkdir -p $DB_PATH
curl -s "http://localhost:3000/api/dashboards/uid/qjch3YsZk"  -u $GF_USER:$GF_PASSWORD|jq -c -M '.[]'|split -l 1 - $DB_PATH

sed -i '1i{"dashboard":' $DB_PATH/ab
echo -e ',"folderId":0,\n"overwrite": true}' >> $DB_PATH/ab
sed -i 's/"graphTooltip":0,"id":1,/"graphTooltip":0,"id":null,/g' $DB_PATH/ab
