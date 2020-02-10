# RPA_Dashboard

### Before install:
If you want to add username and password to postgress add the following lines to database.env, choose database name, user and password (don't use defaults):
```
POSTGRES_DB=databasename
POSTGRES_USER=user
POSTGRES_PASSWORD=password
```

### To run:
docker-compose build
docker-compose up

### To remove:
`docker stop jenkins`
`docker-compose down`
`docker rmi roboteam/custom-jenkins roboteam/custom-grafana postgres:alpine`
