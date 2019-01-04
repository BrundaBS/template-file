#!/bin/bash

#copy template files to rosco
cp /home/halyard/template-file-manifests/*.json /home/halyard/.hal/default/profiles/rosco/packer/

hal deploy apply --service-names=rosco