#!/bin/bash

echo "... generating self-signed cert"

cat >${HOPS_YAML_FILES}/server.conf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
prompt = no
[req_distinguished_name]
CN = model-serving-webhook.hops-system.svc
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = model-serving-webhook.hops-system.svc
EOF

# Generate the CA cert and private key
openssl req -nodes -new -x509 -keyout ${HOPS_YAML_FILES}/model-serving-webhook-ca.key -out ${HOPS_YAML_FILES}/model-serving-webhook-ca.crt -subj "/CN=Model Serving Webhook CA"

# Generate the private key for the webhook server
openssl genrsa -out ${HOPS_YAML_FILES}/model-serving-webhook.key ${MODEL_SERVING_WEBHOOK_CERT_KEY_SIZE}

# Generate a Certificate Signing Request (CSR) for the private key, and sign it with the private key of the CA.
openssl req -new -key ${HOPS_YAML_FILES}/model-serving-webhook.key -subj "/CN=model-serving-webhook.hops-system.svc" -config ${HOPS_YAML_FILES}/server.conf \
    | openssl x509 -req -CA ${HOPS_YAML_FILES}/model-serving-webhook-ca.crt -CAkey ${HOPS_YAML_FILES}/model-serving-webhook-ca.key -CAcreateserial -out ${HOPS_YAML_FILES}/model-serving-webhook.crt -extensions v3_req -extfile ${HOPS_YAML_FILES}/server.conf

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