#!/bin/bash

DOCKER_REPO="mosakrm01/simpleapp"   # CHANGE THIS
IMAGE_NAME="simpleapp"

# Function to check command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ensure curl is installed
if ! command_exists curl; then
    sudo apt update
    sudo apt install -y curl
else
    echo "Curl already installed"
fi

# Install Docker
if ! command_exists docker; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
else
    echo "Docker already installed"
fi

# Build Docker Image and push
sudo docker build -t $IMAGE_NAME .

sudo docker tag $IMAGE_NAME $DOCKER_REPO

sudo docker push $DOCKER_REPO

# Install minikube
if ! command_exists minikube; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    sudo dpkg -i minikube_latest_amd64.deb
else
    echo "Minikube already installed"
fi

# Start minikube with Docker driver
bash otherScript.sh
minikube start --driver=docker

# Install kubectl manually
KUBECTL_VERSION="v1.34.0"
if ! command_exists kubectl; then
    echo "Installing kubectl $KUBECTL_VERSION"
    curl -LO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"

    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    echo "kubectl installed successfully"
else
    echo "Kubectl already installed"
fi

# Create Deployment and Service
kubectl create deployment simpleapp --image=$DOCKER_REPO --replicas=3
kubectl patch deployment simpleapp \
  -p '{"spec":{"template":{"spec":{"containers":[{"name":"simpleapp","imagePullPolicy":"Never"}]}}}}'


kubectl expose deployment simpleapp --port=80 --target-port=5000 --type=LoadBalancer

minikube service simpleapp
