# RPA_Dashboard

## What is it?

RPA Dashboard is a dashboard to launch RPA jobs made with Robot Framework.

It uses open source software and integrates everything smootly into one customizable dashboard.

## Installation

[Installation manual](documentation/installation.md)

## Create your first job and run it

[Setting up jobs and launching them](documentation/manual.md)

## Setting up Certificate Authority for web domain

[Setting up Let's Encrypt](documentation/lets_encrypt.md)

## How it all works?
[Architecture](documentation/architecture.md)

## Processes and where you can find them
Nginx redirects the url to correct local address.

| Process          | Url               | local port | open port |
| ---------------- | ----------------- | ---------- | --------- |
| Grafana          | domain/           | 3000       |           |
| Jenkins          | jenkins.domain/   | 8080       |           |
| Backend          | backend.domain/   | 4000       |           |
| Postgres         |                   | 5432       |           |
| Docker in Docker |                   | 2376       |           |
| Watchtower       |                   |            |           |
| Nginx            |                   | 80, 443    | 80, 443   |

### Problems related with DbBot-SQLalchemy

DbBot proved not to be suitable for saving task related data. This is why we had to create our own dbsaver, that saves required data from the task. More about that [here](documentation/dbbotreport.md)

## Playbooks

#### shutdown.yml

Kills and removes all containers. Run site.yml to restart app.

#### nuke.yml

Kill and removes all containers and volumes. Deletes all files used by the application. Run only if you want to reset.
