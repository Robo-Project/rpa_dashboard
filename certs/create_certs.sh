#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
openssl req -x509 -newkey rsa:4096 -keyout $DIR/robo.key -out $DIR/robo.crt -days 365 -nodes -subj "/C=FI/L=Helsinki/O=Robo-Team/CN=RoboticProcessAutomationDashboard"
