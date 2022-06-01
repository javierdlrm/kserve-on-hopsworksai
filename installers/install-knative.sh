#!/bin/bash

echo "... installing knative crds"

kubectl apply -f ${HOPS_YAML_FILES}/knative-serving-crds.yml

printf "\n... installing knative serving \n"

kubectl apply -f ${HOPS_YAML_FILES}/knative-serving.yml

printf "\n... configuring knative with istio \n"

kubectl apply -f ${HOPS_YAML_FILES}/knative-istio.yml
