#!/bin/bash

echo "... applying hops-system"

kubectl apply -f ${HOPS_YAML_FILES}/hops-system.yml