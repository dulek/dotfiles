#!/bin/bash -x

ns=$1
pod=$2
tag=${3:-latest}

oc project $ns
until [[ `oc get pod $pod-build -o=jsonpath='{.status.phase}'` =~ "Succeeded" ]] ; do
    echo "Waiting for $pod build..."
    sleep 5s
done
docker pull registry.build02.ci.openshift.org/$ns/stable:$pod
docker tag registry.build02.ci.openshift.org/$ns/stable:$pod quay.io/dulek/$pod:$tag
docker --config ~/.docker/quay push quay.io/dulek/$pod:$tag
