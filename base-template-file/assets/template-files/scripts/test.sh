curl -s "http://metadata.google.internal/computeMetadata/v1/project/attributes/jenkins_ssh_key" -H "Metadata-Flavor: Google" >> /home/jenkins/ssh_key
chown -R jenkins:jenkins /home/jenkins/ssh_key

gcloud compute instances create image-test --image=$IMAGE_NAME --subnet=default --zone=us-east4-c

gcloud compute ssh image-test --zone us-east4-c --ssh-key-file=/home/jenkins/ssh_key

/tmp/gossfolder/goss --version

cd /tmp/gossfolder
 
GOSS_FAIL_COUNT=$(sudo /tmp/gossfolder/goss validate | grep "Failed:" | awk '{print substr($4,1,1)}')

if [ $GOSS_FAIL_COUNT == 0 ]
 then
 echo "Goss test failed!!!"
 gcloud compute images delete $IMAGE_NAME
fi

echo "Goss test passed"


