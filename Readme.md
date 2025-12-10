## You Can Just Run Script.sh and will do everything for you ##

Program Part

1. Install Python if you did not already:
sudo apt install python3
2. Install Pip
sudo apt install sudo apt install Python3-pip
3. Install Flask using pip
pip install Flask

Docker Part

4. Install Curl if you did not already:
sudo apt install curl
5. Install Docker using this script:
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
6. Build the Dockerfile included
docker build -t simpleapp
7. Run the image
docker run -d -p5000:5000 simpleapp
8. Push the image into ur repo in Dockerhub
docker push yourRepo/simpleapp

K8 Part

9. Install minikube using this script:
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

10. Start minikube with docker as driver:
minikube start --driver=docker

11. Install kubectl:
sudo apt install kubectl

12. Create a Deployment using the image you just pushed and with 3 replicas
kubectl create deployment simpleapp --image=yourRepo/simpleapp --replicas=3

13. Check what you have done
kubectl get all

14. Create a service
kubectl expose deployment simpleapp --port=80 --target-port=5000 --type=LoadBalancer

15. Tunnel it using minikube
minikube service simpleapp

