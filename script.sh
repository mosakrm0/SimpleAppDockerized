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

#2 Installing Docker
if ! command_exists docker; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
else
    echo "Docker already installed"
fi

#3 Building Docker Image and pushing
docker build -t $IMAGE_NAME .

docker tag $IMAGE_NAME $DOCKER_REPO

docker push $DOCKER_REPO

#4 Installing minikube
if ! command_exists minikube; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    sudo dpkg -i minikube_latest_amd64.deb
else
    echo "Minikube already installed"
fi

minikube start --driver=docker

#5 Installing kubectl manually
KUBECTL_VERSION="v1.34.0"
if ! command_exists kubectl; then
    echo "Installing kubectl $KUBECTL_VERSION"
    curl -LO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"

    # Verify SHA256 checksum
    KUBECTL_SHA256_EXPECTED=$(curl -s "https://dl.k8s.io/$KUBECTL_VERSION/bin/linux/amd64/kubectl.sha256")
    KUBECTL_SHA256_ACTUAL=$(sha256sum kubectl | awk '{print $1}')

    if [ "$KUBECTL_SHA256_EXPECTED" != "$KUBECTL_SHA256_ACTUAL" ]; then
        echo "SHA256 checksum verification failed!"
        exit 1
    fi

    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    echo "kubectl installed successfully"
else
    echo "Kubectl already installed"
fi

#6 Create Deployment and Service
kubectl create deployment simpleapp --image=$DOCKER_REPO --replicas=3

kubectl expose deployment simpleapp --port=80 --target-port=5000 --type=LoadBalancer

minikube service simpleapp
