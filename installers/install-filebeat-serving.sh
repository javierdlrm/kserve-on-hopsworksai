#!/bin/bash

echo "... applying filebeat for serving logs"

kubectl apply -f ${HOPS_YAML_FILES}/filebeat-serving.yml