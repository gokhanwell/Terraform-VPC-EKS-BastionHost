#!/bin/bash

apt update -y

apt install unzip -y

#aws-cli

cd /root

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

./aws/install

#aws-cli-configure

mkdir .aws && cd .aws

echo [default] > config && echo region = ${region} >> config && echo output = yaml >> config

echo [default] > credentials && echo aws_access_key_id = ${access_key} >> credentials && echo aws_secret_access_key = ${secret_access_key} >> credentials

chmod 600 config credentials

#helm

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

#kubectl

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

mv ./kubectl /usr/local/bin/kubectl

#kubeconfig

aws eks update-kubeconfig --region ${region} --name Terraform-EKS-Cluster 