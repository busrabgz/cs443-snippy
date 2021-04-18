#!/bin/bash

export VERSION=v1-fix
export PROJECT_ID=snippy-me-cs443
gcloud container clusters get-credentials snippy-cluster

pushd ../core
docker build -t gcr.io/${PROJECT_ID}/cs443-snippy_app:${VERSION} .

pushd ../analytics
docker build -t gcr.io/${PROJECT_ID}/cs443-snippy_analytics:${VERSION} . 

docker push gcr.io/${PROJECT_ID}/cs443-snippy_app:${VERSION}
docker push gcr.io/${PROJECT_ID}/cs443-snippy_analytics:${VERSION}

