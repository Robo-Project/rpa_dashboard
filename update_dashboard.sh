#!/bin/bash
set -o allexport;
source environment/grafana.env;
source environment/postgres.env;
source environment/paths.env;
set +o allexport

sed "s/\"password\":\".*\",\"user\":\".*\",\"database\":\".*\",\"basicAuth\"/\"password\":\"$POSTGRES_PASSWORD\",\"user\":\"$POSTGRES_USER\",\"database\":\"$POSTGRES_DB\",\"basicAuth\"/g" $DS_PATH/aa > $DS_PATH/tmp


curl -X "DELETE" "http://localhost:3000/api/datasources/name/PostgreSQL" \
    -H "Content-Type: application/json" \
    --user $GF_USER:$GF_PASSWORD

curl -X "POST" "http://localhost:3000/api/datasources" \
    -H "Content-Type: application/json" \
     --user $GF_USER:$GF_PASSWORD \
     --data-binary @$DS_PATH/tmp

for i in $DB_PATH/*; do \
    curl -X "POST" "http://localhost:3000/api/dashboards/db" \
    -H "Content-Type: application/json" \
    --user $GF_USER:$GF_PASSWORD \
    --data-binary @$i
done

rm $DS_PATH/tmp
