#!/bin/bash

echo "Exporting env vars..."

export HOPS_YAML_FILES=$PWD/yaml

# hopsworks rest api
export HOPSWORKS_FQDN=hopsworks.glassfish.service.consul
export HOPSWORKS_PORT=8182

# kafka
export KAFKA_BROKERS=kafka.service.consul:9091

# docker registry
export DOCKER_IMG_REG_URL=javierdlrm #registry.service.consul:4443
export DOCKER_IMG_VERSION=latest #2.6.0

# docker images
export STORAGE_INITIALIZER_IMG=storage-initializer:${DOCKER_IMG_VERSION}
export INFERENCE_LOGGER_IMG=inference-logger:${DOCKER_IMG_VERSION}

# istio
export ISTIO_INGRESS_HTTP10="0"
export ISTIO_INGRESS_HTTP_PORT=32080
export ISTIO_INGRESS_HTTPS_PORT=32443
export ISTIO_INGRESS_STATUS_PORT=32021

# knative
export KNATIVE_DOMAIN_NAME=hopsworks.ai

# kserve
export SKLEARNSERVER_IMG=sklearnserver  # without version. it will be appended by kserve 

# model-serving-webhook
export MODEL_SERVING_WEBHOOK_IMG=model-serving-webhook:${DOCKER_IMG_VERSION}

# model-serving-authenticator
export MODEL_SERVING_AUTHENTICATOR_IMG=model-serving-authenticator:${DOCKER_IMG_VERSION}
export MODEL_SERVING_WEBHOOK_CERT_KEY_SIZE=2048
export MODEL_SERVING_WEBHOOK_CERT_DAYS=3650

# filebeat for serving logs
export FILEBEAT_IMG=filebeat:${DOCKER_IMG_VERSION}
export LOGSTASH_ENDPOINT=logstash.service.consul:5046
