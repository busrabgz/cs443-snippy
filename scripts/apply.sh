#!/bin/bash

pushd ..

kubectl apply -f core/deployment/deployment.yaml,\
core/deployment/service.yaml,\
core/deployment/autoscale.yaml,\
analytics/deployment/deployment.yaml,\
analytics/deployment/service.yaml,\
analytics/deployment/autoscale.yaml,\
redis_config/redis_deployment.yaml,\
redis_config/redis_service.yaml 

