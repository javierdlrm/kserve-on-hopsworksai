#!/bin/bash

echo "... generating self-signed cert"

openssl genrsa -out ${HOPS_YAML_FILES}/model-serving-webhook.key ${MODEL_SERVING_WEBHOOK_CERT_KEY_SIZE}

openssl req -x509 -new -nodes -key ${HOPS_YAML_FILES}/model-serving-webhook.key \
  -subj "/CN=model-serving-webhook.hops-system.svc" \
  -days ${MODEL_SERVING_WEBHOOK_CERT_DAYS} \
  -out ${HOPS_YAML_FILES}/model-serving-webhook.crt

printf "\n... creating kube TLS secret \n"

kubectl -n hops-system create secret tls model-serving-webhook-tls \
    --cert "${HOPS_YAML_FILES}/model-serving-webhook.crt" \
    --key "${HOPS_YAML_FILES}/model-serving-webhook.key" \
    --dry-run=client --output=yaml \
    > ${HOPS_YAML_FILES}/model-serving-webhook-tls.yml

# Add the CA Bundle to the model-serving-webhook yaml file
export CA_PEM_B64="$(openssl base64 -A <"${HOPS_YAML_FILES}/model-serving-webhook.crt")"
envsubst < ${HOPS_YAML_FILES}/model-serving-webhook.template.yml > ${HOPS_YAML_FILES}/model-serving-webhook.yml
# sed -e 's@${CA_PEM_B64}@'"$ca_pem_b64"'@g' <"${HOPS_YAML_FILES}/model-serving-webhook.yml" \
#     > ${HOPS_YAML_FILES}/model-serving-webhook.yml

printf "\n... installing model-serving-webhook-tls \n"

kubectl apply -f ${HOPS_YAML_FILES}/model-serving-webhook-tls.yml

printf "\n... installing model-serving-webhook \n"

kubectl apply -f ${HOPS_YAML_FILES}/model-serving-webhook.yml