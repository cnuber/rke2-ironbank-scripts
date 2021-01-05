#/bin/bash

bucket_name="rke2-flattened-image-artifacts"
s3_endpoint="s3.us-gov-west-1.amazonaws.com"
aws_region="us-gov-west-1"

cd /vagrant/build/flat-images/docker.io/rancher/

artifactdirs=($(find . -name '*'.xz |cut -d / -f2))

for directory in ${artifactdirs[@]}  ; do

mkdir -p /vagrant/ironbank/manifests/${directory}

wget -O /vagrant/ironbank/manifests/${directory}/Dockerfile https://${bucket_name}.${s3_endpoint}/${directory}/Dockerfile 

archivesha=$(sha256sum /vagrant/build/flat-images/docker.io/rancher/${directory}/flattened.tar.xz |awk '{print $1}')

cat <<EOF > /vagrant/ironbank/manifests/${directory}/download.yaml
---
version: "v1.19.5+rke2r1"
resources:
  - url: "https://${bucket_name}.${s3_endpoint}/${directory}/flattened.tar.xz"
    filename: "flattened.tar.xz"
    validation:
      type: "sha256"
      value: "${archivesha}"
EOF


done

