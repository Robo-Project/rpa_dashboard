# RPA_Dashboard

### To run:
docker-compose up

### To configure Jenkins
Connect to localhost:8080, choose `Create new` and then write up a job name. Choose `multibranch pipeline` and click `ok`. Under `Branch sources`, choose `add source` and select `github`. Add github url (ex. https://github.com/Robo-Project/Robotest1) and scroll to bottom to save.

### To configure Postgres - optional
If you want to add username and password to postgres add the following lines to `environment/postgres.env`, choose database name, user and password:
```
POSTGRES_DB=databasename
POSTGRES_USER=user
POSTGRES_PASSWORD=password
```

### To configure Grafana
Connect to localhost, log in with username `admin` and password `admin`. Change the admin password.
Go to `Configuration -> Data Sources -> PostgreSQL` and change Database, User and Password to match the ones you use. Set SSL Mode to `disable`

If you modify grafana dashboard and want to save it, click `Save dashboard` from Dashboard view, copy the JSON and copy it to path `grafana/dashboards`

On RPA Board, edit tasks and add correct jenkins job names to the path (replace the previous ones).
