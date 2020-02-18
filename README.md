# RPA_Dashboard

### To run:
docker-compose up

### To configure Jenkins
Connect to localhost:8080, choose `Create new` and then write up a job name. Choose `multibranch pipeline` and click `ok`. Under `Branch sources`, choose `add source` and select `github`. Add github url (ex. https://github.com/Robo-Project/Robotest1) and scroll to bottom to save.

### To configure Grafana
Connect to localhost, log in with username `admin` and password `admin`. Change the admin password.
Go to `Configuration -> Data Sources -> PostgreSQL`. Set SSL Mode to `disable`.

On RPA Board, edit tasks and add correct jenkins job name to correct one (replace the "Search" from url path).

If you modify grafana dashboard and want to save it, click `Save dashboard` from Dashboard view, copy the JSON and copy it to path `grafana/dashboards/dash.json`

