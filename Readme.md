## You Can Just Run Script.sh and will do everything for you ##


1. Install minikube using this script:
```curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb```
```sudo dpkg -i minikube_latest_amd64.deb```

2. Start minikube with podman or docker as driver:
```minikube start --driver=docker``` OR ```minikube start --driver=podman```

3. Install kubectl:
```sudo apt install kubectl```

4. Create a Deployment using the image you just pushed and with 3 replicas
```kubectl create deployment simpleapp --image=ghcr.io/mosakrm0/simpleapp --replicas=3```

5. Check what you have done
```kubectl get all```

6. Create a service
```kubectl expose deployment simpleapp --port=80 --target-port=5000 --type=LoadBalancer```

7. Tunnel it using minikube
```minikube service simpleapp```

