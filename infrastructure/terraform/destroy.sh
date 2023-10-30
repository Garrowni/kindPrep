#!/usr/bin/env bash

### This does currently whipe everything
### I need to do research to find the best way to not have to run init again.
set -e

echo "Destroying cluster additional work..."
cd cluster
terraform destroy -auto-approve
echo "Destroying namespace..."

sleep 15

cd ../namespace
terraform destroy -auto-approve
echo "Destroying cluster base..."

sleep 15

cd ../clusterBase
terraform destroy -auto-approve

echo "Removing ~/Documents/tempSensitive/"
rm -r ~/Documents/tempSensitive/

#
#rm -r .terraform
#rm .terraform.lock.hcl
#rm terraform.tfstate
#rm terraform.tfstate.backup


