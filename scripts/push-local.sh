#!/bin/bash
for IMAGELIST in $(sed 's/docker.io\///g' dist/artifacts/rke2-images.*.txt); do
  for IMAGE in $IMAGELIST; do
    docker tag ${IMAGE} localhost:5000/${IMAGE}
    docker push localhost:5000/${IMAGE}
  done
done
