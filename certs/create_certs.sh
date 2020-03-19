#!/bin/bash
openssl req -x509 -newkey rsa:4096 -keyout robo.key -out robo.crt -days 365 -nodes -subj "/C=FI/L=Helsinki/O=Robo-Team/CN=RoboticProcessAutomationDashboard"
