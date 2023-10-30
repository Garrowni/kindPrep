#!/usr/bin/env bash

set -e

cd clusterBase
terraform init
terraform apply -auto-approve

sleep 30
cd ../namespace
terraform init
terraform apply -auto-approve

sleep 30
cd ../cluster
terraform init
terraform apply -auto-approve
