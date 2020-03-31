# RPA_Dashboard

### SETUP BEFORE FIRST RUN
```
Create certificates for SSL by running these commands:
 -> cd certs
 -> ./create_certs.sh
  If it doesn't work, make sure you have openssl installed and in your PATH.

Create file 'postgres.env' on rpa_dashboard root directory.
 -> Write the database information on 3 lines to postgres.env:
 POSTGRES_DB=<database_name>
 POSTGRES_USER=<username>
 POSTGRES_PASSWORD=<password>
 -> save
 -> Change the file permissions to user read only:
   chmod 400 postgres.env
 You will need these later when configuring grafana

Configure nginx

 For server outside local network:
 -> edit 'nginx.conf' file
 -> change all 'server_name' attributes to your domain name or ip-address.
 
 For localhost:
 -> jenkins.localhost does not work unless you edit your '/etc/hosts' file.
 -> change '127.0.0.1 localhost' to '127.0.0.1 *.localhost'

Create 'jenkins-api-token' file on rpa_dashboard root directory. Leave the file empty for now.
```

### To run:
    docker-compose up

Connect to `localhost` or your domain root. Log in to Grafana to view panels.

### To configure Jenkins

#### First login:

If you have previously used rpa_dashboard, make sure you clear all previous containers, volumes and images.
```
Get password from console to unlock jenkins 
 -> Connect to jenkins.localhost (or jenkins.domain)
 -> log in with unlock password
 -> close the window by pressing 'x' in the top right corner, plugins are already installed
```
 
#### Change admin password:
```
Click 'admin' in top-right corner
 -> Configure
 -> Input new password to 'Password' and 'Confirm Password' fields.
 -> Save
 -> Log in with new password
```
 
#### Create admin API-token:
```
Click 'admin' in top-right corner
  -> Configure
  -> API token
    -> Add new Token
  -> Enter any name
  -> Generate
  -> Copy token
  -> Create new file 'jenkins-api-token' to rpa_dashboard root directory.
  IMPORTANT: As this file is a volume in docker, docker might've created it already.
  It has probably made it as a directory. So remove the directory and create the file.
  You might need to take the containers down to do it.
  -> Write your credentials to file as <username>:<api-token>, such as 'admin:11003210391798127509a'
  -> Make sure there is no extra lines in the file.
  -> Save the file.
```

#### Define Jenkins security:
```
Manage Jenkins
 -> Configure Global Security
 -> Select 'Logged-in users can do anything'
 -> uncheck "Allow anonymous read access"
 -> Save
```

#### Create a job:
```
Go to front page of Jenkins
 -> Create new
 -> Write up a job name
 -> Choose multibranch pipeline
 -> Ok
 -> Under 'Branch sources', choose 'add source' and select 'github'. Add github url (ex. https://github.com/Robo-Project/WikiSearch).
 -> Save
```

### To configure Grafana
```
Connect to localhost
 -> log in with username `admin` and password `admin`.
 -> Change the admin password.
 -> Configuration
 -> Data Sources
 -> PostgreSQL
 -> Set username, password and database to correct ones
```

If you modify grafana dashboard and want to save it, click `Save dashboard` from Dashboard view, copy the JSON and copy it to path `grafana/dashboards/dash.json`
