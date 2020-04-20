
## How to create jobs and launch them

### Create a job

- To run a job, you need a robot job created with robot framework, that is in a repository and has a jenkins file. One example is [taxiservice](https://github.com/Robo-Project/taxiservice)
- Login to Jenkins with your browser (see [installation](installation.md))
- On the left side menu, click 'New Item'
- Write up a job name, choose 'Multibranch Pipeline' and click 'OK'
- Under 'Branch Sources', click 'Add source' and select 'GitHub'.
- To 'Repository HTTPS URL' add github url (ex. https://github.com/Robo-Project/taxiservice) .
- Click Save

Note: For some reason, github sometimes puts launching jobs to sleep for several minutes. This can be avoided if github credentials are given for jenkins.

#### About job Jenkinsfile
In our example [taxiservice Jenkins file](https://github.com/Robo-Project/taxiservice/blob/master/Jenkinsfile) there are few things to be noted.

- A service called *dbbot-sqlalchemy* is used to save the data from robot job to postgres database.
- If any special information is needed to be pulled from the robot job and saved to database, the *dbbot-sqlalchemy* has some problems doing that. The problems are better explained [here](dbbotreport.md).

### Launching a job

- To launch a job, we need a job that works from Jenkins. (It can be tested from Jenkins own interface)
- Log in to Grafana (see [installation](installation.md)).
- To see all Dashboards, click 'Home'
- Click 'RPA Board'
- Click 'Launch <jobname>'

Launching parameterized builds is currently not supported.

### Grafana panels

Panels are saved within Grafana container.
Refer to RPA Dashboard Grafana repository for more info.
