# RPA_Dashboard

### To run:
docker-compose up

Remember to also start jenkins-service and rpa_dashboard_frontend

Connect to `localhost`. Log in to Grafana to view panels.

### To configure Jenkins

#### First login:
Get password to unlock jenkins from console
 -> Connect to localhost
 -> log in with unlock password
 -> press x in the windows top right corner, plugins are already installed
 
#### Change admin password:
Go to People
 -> admin
 -> Configure
 -> Input new password to 'Password' and 'Confirm Password' fields.
 -> Save
 -> Log in with new password
 
#### Define Jenkins security:
Manage Jenkins
 -> Configure Global Security
 -> Select 'Logged-in users can do anything'
 -> uncheck "Allow anonymous read access"
 -> Save

#### Create a job:
Connect to localhost:8080, choose `Create new` and then write up a job name. Choose `multibranch pipeline` and click `ok`. Under `Branch sources`, choose `add source` and select `github`. Add github url (ex. https://github.com/Robo-Project/WikiSearch) and scroll to bottom to save.

### To configure Grafana
Connect to localhost:3000, log in with username `admin` and password `admin`. Change the admin password.
Go to `Configuration -> Data Sources -> PostgreSQL`. Set SSL Mode to `disable`.

On RPA Board, edit tasks and add correct jenkins job name to correct one (replace the "Search" from url path).

If you modify grafana dashboard and want to save it, click `Save dashboard` from Dashboard view, copy the JSON and copy it to path `grafana/dashboards/dash.json`

## To do

Use API token to make the post to Jenkins from (front? back? grafana panel?)
