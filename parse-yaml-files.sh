#!/bin/bash

echo "Parsing yaml files..."

# hops-system
envsubst < ${HOPS_YAML_FILES}/hops-system.template.yml > ${HOPS_YAML_FILES}/hops-system.yml

# istio
envsubst < ${HOPS_YAML_FILES}/istio-operator.template.yml > ${HOPS_YAML_FILES}/istio-operator.yml

# knative
envsubst < ${HOPS_YAML_FILES}/knative-serving.template.yml > ${HOPS_YAML_FILES}/knative-serving.yml

# kserve
envsubst < ${HOPS_YAML_FILES}/kserve.template.yml > ${HOPS_YAML_FILES}/kserve.yml

# model-serving-webhook
envsubst < ${HOPS_YAML_FILES}/model-serving-webhook.template.yml > ${HOPS_YAML_FILES}/model-serving-webhook.yml

# model-serving-authenticator
envsubst < ${HOPS_YAML_FILES}/model-serving-authenticator.template.yml > ${HOPS_YAML_FILES}/model-serving-authenticator.yml

# filebeat for serving logs
envsubst < ${HOPS_YAML_FILES}/filebeat-serving.template.yml > ${HOPS_YAML_FILES}/filebeat-serving.yml