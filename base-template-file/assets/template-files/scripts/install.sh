#!/bin/bash

sudo curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh

sudo chmod 777 install-logging-agent.sh

/tmp/gossfolder/goss --version

cd /tmp/gossfolder && /tmp/gossfolder/goss validate