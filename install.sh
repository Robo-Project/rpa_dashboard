#!/bin/bash
git clone https://github.com/Robo-Project/Custom_jenkins_container.git jenkins
docker build -t roboteam/custom-jenkins jenkins/
docker-compose build
