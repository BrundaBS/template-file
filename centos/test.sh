
echo $GIT_BRANCH

gcloud compute instances create image-test --image=$IMAGE_NAME --subnet=default --zone=us-east4-c
#gcloud compute instances create venkyblack123 --image=duplicate3 --subnet=default --zone=us-east4-c
sleep 20

export GOSS_RESULT=$(ssh -i ./sshkey  jenkins_user@image-test -oStrictHostKeyChecking=no '/tmp/gossfolder/goss --version; cd /tmp/gossfolder; sudo /tmp/gossfolder/goss validate')

export GOSS_FAIL_COUNT=$(echo $GOSS_RESULT | cut --delimiter=, -f2 | awk '{print $2}')

echo "fail count:"$GOSS_FAIL_COUNT
if [[ $GOSS_FAIL_COUNT == "0" ]]
 then
  echo "Goss test passed!!!"
  gcloud compute images add-labels $IMAGE_NAME --labels=stable=$GIT_COMMIT
  gcloud compute instances delete image-test --zone=us-east4-c --quiet
  exit 0
fi

echo "Goss test Failed!!!"
gcloud compute images delete $IMAGE_NAME --quiet
gcloud compute instances delete image-test --zone=us-east4-c --quiet
exit 1
