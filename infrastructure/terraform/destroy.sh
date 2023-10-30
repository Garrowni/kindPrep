#!/usr/bin/env bash

set -e
cd cluster
terraform destroy -auto-approve

sleep 15

cd ../namespace
terraform apply -auto-approve

sleep 15

cd ../clusterBase
terraform apply -auto-approve
