#!/bin/bash

DOCKER_REPO="mosakrm01/simpleapp"   #CHANGE THIS
IMAGE_NAME="simpleapp"


#1 Installing Python and Flask
sudo apt update
sudo apt install -y python3 python3-pip

pip install Flask

#2 Installing Docker
sudo apt install -y curl

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

#3 Building Docker Image And tag it then Push it
docker build -t $IMAGE_NAME .

docker tag $IMAGE_NAME $DOCKER_REPO

docker push $DOCKER_REPO

#4 Installing minikube then start it
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

minikube start --driver=docker

#5 Installing Kubectl
sudo snap install -y kubectl

#6 Create Deployment, And Exposing it to a Server, Tunnel it through minicube
kubectl create deployment simpleapp --image=$DOCKER_REPO --replicas=3

kubectl expose deployment simpleapp --port=80 --target-port=5000 --type=LoadBalancer

minikube service simpleapp

