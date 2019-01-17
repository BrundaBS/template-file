
echo $GIT_BRANCH


gcloud compute instances create image-test --image=$IMAGE_NAME --subnet=default --zone=us-east4-c
#gcloud compute instances create venkyblack123 --image=duplicate3 --subnet=default --zone=us-east4-c
 
export GOSS_RESULT=$(ssh -i ./sshkey  jenkins_user@image-test -oStrictHostKeyChecking=no '/tmp/gossfolder/goss --version; cd /tmp/gossfolder; sudo /tmp/gossfolder/goss validate')

export GOSS_FAIL_COUNT=$(echo $GOSS_RESULT | grep "Failed:" | awk '{print substr($11,1,1)}')

if [ $GOSS_FAIL_COUNT == 0 ]
 then
 echo "Goss test passed!!!"
fi

