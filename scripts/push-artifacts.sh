#/bin/bash

bucket_name="rke2-flattened-image-artifacts"
s3_endpoint="s3.us-gov-west-1.amazonaws.com"
aws_region="us-gov-west-1"

cd /vagrant/build/flat-images/docker.io/rancher/

artifactdirs=($(find . -name '*'.xz |cut -d / -f2))

for directory in ${artifactdirs[@]}  ; do

aws s3 sync ${directory} s3://${bucket_name}/${directory} --endpoint https://${s3_endpoint} --region ${aws_region}

done

