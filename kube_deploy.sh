#!/bin/bash


kubectl apply -f core/deployment/deployment.yaml,core/deployment/service.yaml,analytics/deployment/deployment.yaml,analytics/deployment/service.yaml
