#!/bin/bash

# exit when any command fails
set -e

echo "[0/8] Preparing env vars and yml files..."
. export-variables.sh
./parse-yaml-files.sh

# install hops-system
printf "\n[1/8] Installing hops-system... \n"
./installers/install-hops-system.sh

# install istio
printf "\n[2/8] Installing istio... \n"
./installers/install-istio.sh

# knative
printf "\n[3/8] Installing knative... \n"
./installers/install-knative.sh

# cert-manager
printf "\n[4/8] Installing cert-manager... \n"
./installers/install-cert-manager.sh

# kserve
printf "\n[5/8] Installing kserve... \n"
./installers/install-kserve.sh

# model-serving-webhook
printf "\n[6/8] Installing model serving webhook... \n"
./installers/install-model-serving-webhook.sh

# model-serving-authenticator
printf "\n[7/8] Installing model serving authenticator... \n"
./installers/install-model-serving-authenticator.sh

# filebeat
printf "\n[8/8] Installing filebeat for serving logs... \n"
./installers/install-filebeat-serving.sh