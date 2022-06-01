#!/bin/bash

echo "... downloading istioctl binaries"

# download binaries
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.10.3 sh -

# add istioctl to PATH
cd istio-1.10.3
export PATH=$PWD/bin:$PATH
cd ..

printf "\n... installing istio operator \n"
istioctl install --skip-confirmation -f ${HOPS_YAML_FILES}/istio-operator.yml

printf "\n... applying envoy filter (auth) \n"
kubectl apply -f ${HOPS_YAML_FILES}/istio-envoy-filter.yml
