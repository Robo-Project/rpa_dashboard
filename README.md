# RPA_Dashboard

### Before install:
Create postgres directory:
`mkdir postgres`
Create file 'database.env' to postgres directory:
`touch postgres/database.env`
Add the following lines to database.env, choose database name, user and password (don't use defaults):
```
POSTGRES_DB=databasename
POSTGRES_USER=user
POSTGRES_PASSWORD=password
```

### To install and run:
`./install.sh`

### To remove:
`docker stop jenkins`
`docker-compose down`
`docker rmi roboteam/custom-jenkins roboteam/custom-grafana postgres:alpine`
