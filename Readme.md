## You Can Just Run Script.sh and will do everything for you ##


Docker Part

1. Install Curl if you did not already:
```sudo apt install curl```
2. Install Docker using this script:
```curl -fsSL https://get.docker.com -o get-docker.sh```
```sh get-docker.sh```
3. Build the Dockerfile included
```docker build -t simpleapp```
4. Run the image
```docker run -d -p5000:5000 simpleapp```
5. Push the image into ur repo in Dockerhub
```docker push yourRepo/simpleapp```

K8 Part

6. Install minikube using this script:
```curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb```
```sudo dpkg -i minikube_latest_amd64.deb```

7. Start minikube with docker as driver:
```minikube start --driver=docker```

8. Install kubectl:
```sudo apt install kubectl```

9. Create a Deployment using the image you just pushed and with 3 replicas
```kubectl create deployment simpleapp --image=yourRepo/simpleapp --replicas=3```

10. Check what you have done
```kubectl get all```

11. Create a service
```kubectl expose deployment simpleapp --port=80 --target-port=5000 --type=LoadBalancer```

12. Tunnel it using minikube
```minikube service simpleapp```

