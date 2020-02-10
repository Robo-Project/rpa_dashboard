# RPA_Dashboard

### To configure Jenkins
Connect to localhost:8080, choose `Create new` and then write up a job name. Choose `multibranch pipeline` and click `ok`. Under `Branch sources`, choose `add source` and select `github`. Add github url (ex. https://github.com/tumajote/robotest2) and scroll to bottom to save.

### To configure Postgres
If you want to add username and password to postgres add the following lines to `environment/postgres.env`, choose database name, user and password (don't use defaults):
```
POSTGRES_DB=databasename
POSTGRES_USER=user
POSTGRES_PASSWORD=password
```

### To configure Grafana
Connect to localhost:3000, log in with username `admin` and password `admin`. Change the admin password.
add USER and PASSWORD variables to the `environment/grafana.env` file:
```
GF_USER=username (admin normally)
GF_PASSWORD=yourSelectedPassword
```
Update Grafana data sources and dashboard by running an update script:
`./update_dashboard.sh`

If you modify grafana dashboard or data sources, export them by running a get script:
`./get_dashboard.sh`
The data sources and dashboard are saved to `grafana` directory.

