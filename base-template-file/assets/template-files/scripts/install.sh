#!/bin/bash

sudo curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh

sudo chmod 777 install-logging-agent.sh

sudo yum update 

sudo yum -y install java-1.8.0-openjdk-headless

sudo yum -y install java-1.8.0-openjdk-devel

