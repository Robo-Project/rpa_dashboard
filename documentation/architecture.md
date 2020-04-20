# Architechture

## Docker
The main component in this project is docker.

Everything runs in their own containers.

## Environment variables
in file `.env` there are 5 environment variables:
- BACKURL
- BACKTOKEN
- POSTGRES_DB
- POSTGRES_USER
- POSTGRES_PASSWORD

And also, there exists file
- jenkins-api-token

#### BACKURL
- BACKURL needs full address for the backend (jenkins-service).
- BACKURL is injected into Grafanas Task Launch Panel, so it can send requests to correct address.

#### BACKTOKEN
- This token is used to verify, that the requests are coming from legitimate sources to backend.
- Used by Grafana Task Launch Panel and backend (jenkins-service).

#### POSTGRES_DB, POSTGRES_USER and POSTGRES_PASSWORD
Database name, user and password for Postgres.
Used by Grafana and Postgres.

#### jenkins-api-token
- Save Jenkins API Token to this file.
- Used by backend to contact Jenkins

## Grafana
Grafana is used as the main dashboard.

Grafana has dashboards, which are customizable.

Currently we have two dashboards:
- RPA Board
  - Used to list robot jobs and launch them
    - Uses custom panel
  - Used to see general info about jobs
- Taxiservice Dashboard
  - Used to display data about taxiservice results.

#### Task Launch Panel to list jobs and launch them
- Uses BACKTOKEN to contact backend service.
- Reads list of all Jenkins jobs through backend service.
- Jobs can be launched from here through backend service.

## Backend (Jenkins-Service)
Backend works between Grafana and Jenkins.

- Jenkins API couldn't be contacted straight from browser, it needs backend in between.
- Extra layer of security when using own token from Grafana.
  - If Grafana would use Jenkins API token, anything could be done with it if it gets stolen. Now only certain actions can be taken if BACKTOKEN gets stolen.
- Reads the jenkins-api-token file each time a request is made. Therefore it's easy to change/renew the API token on Jenkins, requiring no restarting of services.

## Jenkins
Robot jobs get launched from here, using [dbbot-sqlalchemy](https://pypi.org/project/dbbot-sqlalchemy/).

- Uses Docker in Docker (jenkins_docker in docker-compose.yml) to launch robot jobs as containers inside Jenkins container.
- Runs dbbot-sqlalchemy to run the robot and save it's data as output.
- As API Token cannot be generated before running Jenkins. It's saved to file where it's read by backend. This means no restarting is required.

## Postgres
Used as database to save data general data from robot jobs.

## Nginx
Works as a reverse proxy for Grafana, Jenkins and Backend.

- All internet traffic goes through nginx.
- All traffic to nginx is encrypted.
- Locally almost all traffic goes through nginx.
  - Only exception is Grafana calls to backend. Browser blocks https requests when it can't certify the authority. Locally you can't have certificate authority.
- Uses Lets Encrypt certificates for HTTPS encryption in internet.
- Only ports 80 (http) and 443 (https) are open to the internet.

## Watchtower
Updates docker images to newest versions.

- Checks for an update once in every 5 minutes or so.
- Updates the image and restarts the container with the new image.
