
echo $GIT_BRANCH


gcloud compute instances create image-test --image=$IMAGE_NAME --subnet=default --zone=us-east4-c
#gcloud compute instances create venkyblack123 --image=duplicate3 --subnet=default --zone=us-east4-c
 
export GOSS_RESULT=$(ssh -i ./sshkey  jenkins_user@image-test -oStrictHostKeyChecking=no '/tmp/gossfolder/goss --version; cd /tmp/gossfolder; sudo /tmp/gossfolder/goss validate')

export GOSS_FAIL_COUNT=$(echo $GOSS_RESULT | grep "Failed:" | awk '{print substr($11,1,1)}')

if [ $GOSS_FAIL_COUNT == 0 ]
 then
 echo "Goss test passed!!!"
fi

 export IMAGE_NAME=$(echo $FILE | rev | cut -d '.' -f2 | rev)-$(date +"%Y%m%d")
         echo $IMAGE_NAME
         /usr/local/packer build $updated_file
        
         chmod +x ./base-template-file/assets/template-files/scripts/test.sh
         ./base-template-file/assets/template-files/scripts/test.sh
         
         echo "image name is"$IMAGE_NAME
         gcloud compute images add-labels $IMAGE_NAME --labels=stable=$GIT_COMMIT
