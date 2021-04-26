Instalar minikube 

https://v1-17.docs.kubernetes.io/docs/tasks/tools/install-minikube/

https://blog-es.mimacom.com/introduccion-kubernetes-minikube/

Install minikube via direct Download

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
  
sudo mkdir -p /usr/local/bin/
sudo dnf install minikube /usr/local/bin/

Comprobar 
minikube status

A
minikube start


BORRAR PV 
kubectl delete pv nombre_pv
kubectl delete pv mysql-pv

