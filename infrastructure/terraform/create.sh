#!/usr/bin/env bash

set -e

echo "Setting up base for the cluster..."
cd clusterBase
terraform init
terraform apply -auto-approve

echo "Setting up namespace for the cluster..."
sleep 30
cd ../namespace
terraform init
terraform apply -auto-approve

echo "Setting up reminder of the initial cluster..."
sleep 30
cd ../cluster
terraform init
terraform apply -auto-approve

echo "Starting setup script for ArgoCD..."
cd ../
./setupArgo.sh