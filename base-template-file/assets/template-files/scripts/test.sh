curl -s "http://metadata.google.internal/computeMetadata/v1/project/attributes/jenkins_ssh_key" -H "Metadata-Flavor: Google" >> /var/lib/jenkins/ssh_key
chown -R jenkins:jenkins /var/lib/jenkins/ssh_key

#gcloud compute instances create venkyblack --image=$IMAGE_NAME --subnet=default --zone=us-east4-c
gcloud compute instances create venkyblack123 --image=duplicate3 --subnet=default --zone=us-east4-c

gcloud compute ssh venkyblack123 --zone us-east4-c --ssh-key-file=/var/lib/jenkins/ssh_key --strict-host-key-checking=no

/tmp/gossfolder/goss --version

cd /tmp/gossfolder
 
GOSS_FAIL_COUNT=$(sudo /tmp/gossfolder/goss validate | grep "Failed:" | awk '{print substr($4,1,1)}')

if [ $GOSS_FAIL_COUNT == 0 ]
 then
 echo "Goss test passed!!!"
fi

echo "Goss test fail"
gcloud compute images delete $IMAGE_NAME



