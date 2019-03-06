#!/bin/bash
#set -e

LETS_ENCRYPT_ENABLED=${LETS_ENCRYPT_ENABLED:-false}
PUBLIC_DNS=${PUBLIC_DNS:-'wordpress.example.com'}
ORGANISATION_UNIT=${ORGANIZATION_UNIT:-'Cloud Native Application'}
ORGANISATION=${ORGANISATION:-'example inc'}
CITY=${CITY:-'Paris'}
STATE=${STATE:-'Paris'}
COUNTRY_CODE=${COUNTRY:-'FR'}
KEYSTORE_PASS=${KEYSTORE_PASS:-'V3ry1nS3cur3P4ssw0rd'}
KEY_PASS=${KEYSTORE_PASS:-$KEYSTORE_PASS}

SSL_CERT_PATH=${SSL_CERT_PATH:-'/etc/nginx/ssl'}
mkdir -p ${SSL_CERT_PATH}


    openssl req -subj "/CN=${PUBLIC_DNS}/OU=${ORGANISATION_UNIT}/O=${ORGANISATION}/L=${CITY}/ST=${STATE}/C=${COUNTRY_CODE}" -new -newkey rsa:2048 -sha256 -days 3650 -nodes -x509 -keyout $SSL_CERT_PATH/nginx.key -out $SSL_CERT_PATH/nginx.crt

exec "$@"
