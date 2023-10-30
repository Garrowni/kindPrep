#!/usr/bin/env bash

#1. add a check to make sure in correct context

echo "Creating argocd namespace..."
kubectl create ns argocd

echo "Applying manifest from argocd github..."
sleep 20

#3 apply manifest from argocd github
    #https://github.com/argoproj/argo-cd
    #releases and info for HA and NON-HA
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.8/manifests/install.yaml

echo "Running port forward in seperate terminal" 

osascript -e 'tell app "Terminal"
    do script "sleep 30 \
    kubectl port-forward svc/argocd-server -n argocd 8080:443 "
end tell'

echo "..."
echo "..."
sleep 30
echo "Creating file for argo password at ~/Documents/tempSensitive/Pass/argoPass"
mkdir -p ~/Documents/tempSensitive/Pass

echo "ArgoCD Password:" >> ~/Documents/tempSensitive/Pass/argoPass.txt
# append the password to the file
(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d;) >> ~/Documents/tempSensitive/Pass/argoPass.txt 
echo ""
echo "Don't forget to delete this file once you have copied over or changed the password!" >> ~/Documents/tempSensitive/Pass/argoPass.txt

echo "Password created. Script complete. Please Remember to delete the file afterwords."
echo "Note: If you run the destroy.sh script that deletes the tf infrastructure, it will also delete ~/Documents/tempSensitive and every file/directory within it.."
