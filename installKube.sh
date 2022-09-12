#!/usr/bin/env bash
# Installs kubectl to allow jenkins to communicate with Kubernetes API server

curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl
chmod 777 ./kubectl
mkdir -p $1/bin && cp ./kubectl $1/bin/kubectl && export PATH=$2:$1/bin