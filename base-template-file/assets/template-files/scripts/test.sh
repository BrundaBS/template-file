gcloud compute instances create image-test2 --image=$IMAGE_NAME --subnet=default --zone=us-east4-c

gcloud compute ssh image-test1 --zone us-east4-c --ssh-key-file=/var/lib/jenkins/workspace/packer-test/spicy --command "/tmp/gossfolder/goss --version"

/tmp/gossfolder/goss --version

cd /tmp/gossfolder
 
GOSS_FAIL_COUNT=$(sudo /tmp/gossfolder/goss validate | grep "Failed:" | awk '{print substr($4,1,1)}')

if [ $GOSS_FAIL_COUNT == 0 ]
 then
 echo "Goss test passed!!!"
fi

echo "Goss test failed"
gcloud compute images delete $IMAGE_NAME


