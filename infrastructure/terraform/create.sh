#!/usr/bin/env bash

set -e

cd clusterBase
terraform apply -auto-approve

sleep 30
cd ../namespace
terraform apply -auto-approve

sleep 30
cd ../cluster
terraform apply -auto-approve

### testing
#printf "\nWaiting for the echo web server service... \n"
#kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
#sleep 10
#
#printf "\nYou should see 'foo' as response below if your ingress is working:\n"
#curl http://localhost/foo