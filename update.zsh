#!/bin/zsh

set -e
set -vx
user=billtuba13
image_id=nginx
tag=$1
new_tag=$user/$image_id:$tag

docker tag nginx:1.23.3 $new_tag
docker push $new_tag

mkdir -p /tmp/
rm -rf /tmp/argo-k8-tutorial

git clone https://github.com/billtuba/argo-k8-tutorial.git /tmp/argo-k8-tutorial

pushd .

cd /tmp/argo-k8-tutorial
sed -i "s/\(image:\).*$/\1 ${user}\/${image_id}:${tag}/"  my-app/1-deployment.yaml
git add my-app/1-deployment.yaml

git commit -m "version bump ${new_tag}"
git push

popd

rm -rf /tmp/argo-k8-tutorial
set +vx
set +e


# does she have to do her own prayers of renunciation of Free Masonry?
