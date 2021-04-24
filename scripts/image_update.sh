#!/bin/bash

export VERSION=v2
export PROJECT_ID=snippy-me-cs443
gcloud container clusters get-credentials autopilot-cluster-1 

pushd ../core
docker build -t eu.gcr.io/${PROJECT_ID}/cs443-snippy_app:${VERSION} -t eu.gcr.io/${PROJECT_ID}/cs443-snippy_app:latest .

pushd ../analytics
docker build -t eu.gcr.io/${PROJECT_ID}/cs443-snippy_analytics:${VERSION} -t eu.gcr.io/${PROJECT_ID}/cs443-snippy_analytics:latest . 

docker push eu.gcr.io/${PROJECT_ID}/cs443-snippy_app:${VERSION}
docker push eu.gcr.io/${PROJECT_ID}/cs443-snippy_app:latest
docker push eu.gcr.io/${PROJECT_ID}/cs443-snippy_analytics:${VERSION}
docker push eu.gcr.io/${PROJECT_ID}/cs443-snippy_analytics:latest

