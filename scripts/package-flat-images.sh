#!/usr/bin/env bash
set -ex
shopt -s nullglob
RKE2_VERSION=v1.19.5+rke2r1
wget -O dist/artifacts/rke2-images.linux-amd64.txt https://github.com/rancher/rke2/releases/download/$RKE2_VERSION/rke2-images.linux-amd64.txt

mkdir -p build/flat-images

for IMAGELIST in dist/artifacts/rke2-images.*.txt; do
  echo "Processing images from ${IMAGELIST}"
  BASENAME=$(basename -s .txt ${IMAGELIST})
  SCRIPT="build/flat-images/${BASENAME}.sh"
  ARCH="${BASENAME#rke2-images.linux-}"
  echo '#!/usr/bin/env bash' > ${SCRIPT}
  echo 'cd $(dirname $0)' >> ${SCRIPT}
  chmod a+x ${SCRIPT}
  for IMAGE in $(cat ${IMAGELIST}); do
    echo "Flattening image ${IMAGE} for ${ARCH}"
    ID=$(docker create ${IMAGE} /pause)
    TAR="build/flat-images/${IMAGE}-${ARCH}/flattened.tar.xz"
    DOCKERFILE="build/flat-images/${IMAGE}-${ARCH}/Dockerfile"
    mkdir -p $(dirname "${TAR}")

    docker cp ${ID}:/ - | xz -T0 -v -3 > ${TAR}
    docker rm ${ID}

    echo "FROM scratch" > ${DOCKERFILE}
    echo "ADD flattened.tar.xz /" >> ${DOCKERFILE}
    docker image inspect ${IMAGE} | jq -r '.[0].Config.Labels | if . then ( . | to_entries | map("LABEL " + .key + "=\"" + .value + "\"") | join("\n") ) else "" end' >> ${DOCKERFILE}
    docker image inspect ${IMAGE} | jq -r '.[0].Config.Env | if . then ( . | map("ENV " + ( . | gsub(" "; "\\ ") )) | join("\n") ) else "" end' >> ${DOCKERFILE}
    docker image inspect ${IMAGE} | jq -r '.[0].Config.User | if . != "" then "USER " + . else "" end' >> ${DOCKERFILE}
    docker image inspect ${IMAGE} | jq -r '.[0].Config.WorkingDir | if . != "" then "WORKDIR " + . else "" end' >> ${DOCKERFILE}
    docker image inspect ${IMAGE} | jq -r '.[0].Config.Cmd | if . then "CMD " + ( . | tojson ) else "" end' >> ${DOCKERFILE}
    docker image inspect ${IMAGE} | jq -r '.[0].Config.Entrypoint | if . then "ENTRYPOINT " + ( . | tojson ) else "" end' >> ${DOCKERFILE}

    echo "docker build -t ${IMAGE}-${ARCH} ${IMAGE}-${ARCH}" >> ${SCRIPT}
    echo "docker manifest create ${IMAGE} ${IMAGE}-${ARCH}" >> ${SCRIPT}
  done
done

tar -cvf dist/artifacts/rke2-flat-images.linux.tar -C build/flat-images .
