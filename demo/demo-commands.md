# MONDODB + MONGO-EXPRESS

## MONGODB 

Crear deployment

	$ vim mongo.yaml

Crear secret

	$ vim mongo-secret.yaml

Lanzar secret

	$ kubectl apply -f mongo-secret.yaml

Examinar secret

	$ kubectl get secret

Lanzar deployment

	$ kubectl apply -f mongo.yaml
	
Examinar

	$ kubectl get all
	
	$ kubectl get pod
	
	$ kubectl describe pod <pod-name>
	
Crear service

	$ vim mongo.yaml
	
Lanzar service

	$ kubectl apply -f mongo.yaml
	
Examinar servicio

	$ kubectl get service
	
	$ kubectl describe service mongodb-service
	
	$ kubectl get pod -o wide
	
	$ kubectl get all | grep mongodb
	

## MONGO-EXPRESS
https://hub.docker.com/_/mongo-express

Crear deployment

	$ vim mongo-express.yaml
	
Crear configmap

	$ vim mongo-configmap.yaml
	
Lanzar configmap y deployment

	$ kubectl apply -f mongo-configmap.yaml
	
	$ kubectl apply -f mongo-express.yaml
	
Examinar

	$ kubectl get pod
	
	$ kubectl logs <pod-name>
	
Crear servicio

	$ vim mongo-express.yaml
	
Lanzar servicio

	$ kubectl apply -f mongo-express.yaml
	
Examinar y obtener dirección del servicio (IP + port)

	$ minikube service mongo-express-service
	

	
	
	
	

