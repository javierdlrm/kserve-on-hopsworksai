#!/bin/bash

echo "... installing kserve"

kubectl apply -f ${HOPS_YAML_FILES}/kserve.yml