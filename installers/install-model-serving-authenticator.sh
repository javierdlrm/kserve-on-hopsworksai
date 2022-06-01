#!/bin/bash

echo "... installing model-serving-authenticator"

kubectl apply -f ${HOPS_YAML_FILES}/model-serving-authenticator.yml