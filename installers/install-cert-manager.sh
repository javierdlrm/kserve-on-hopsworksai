#!/bin/bash

echo "... applying cert-manager"

kubectl apply -f ${HOPS_YAML_FILES}/cert-manager.yml