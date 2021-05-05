# Comandos básicos kubectl

## Visualizar información

- **Nodos:**

		$ kubectl get no
	
		$ kubectl get no -o wide
	
		$ kubectl describe no
	
		$ kubectl get no -o yaml
	
		$ kubectl get nodes -o [jsonpath]
	
		$ kubectl top node [node-name]
	
	
- **Pods**

		$ kubectl get po
	
		$ kubectl get pod -o wide
	
		$ kubectl describe pods
	
		$ kubectl get po --show-labels
	 
		$ kubectl get po -l app=nginx
	
		$ kubectl get po -o yaml
	
		$ kubectl get pod [pod_name] -o yaml --export
	
		$ kubectl get pod [pod_name] -o yaml --export > file.yaml
	

- **Namespaces:**

		$ kubectl get namespaces 
	
		$ kubectl get ns -o yaml
	
		$ kubectl describe ns
	
	
- **Deployments:**

		$ kubectl get deployments
	
		$ kubectl describe deploy
	
		$ kubectl get deploy -o wide
	
		$ kubectl get deploy -o yaml
	
	
- **Services:**

		$ kubectl get services
	
		$ kubectl describe svc
	
		$ kubectl get svc -o wide
	
		$ kubectl get svc -o yaml
	
		$ kubectl get svc --show-labels
	
	
- **ServiceAccounts:**

		$ kubectl get serviceaccounts 
	
		$ kubectl get sa -o yaml
	
		$ kubectl get serviceaccounts default -o yaml > sa.yaml
	
		$ kubectl replace serviceaccount default -f sa.yaml
	
	
- **ReplicaSets:**

		$ kubectl get replicasets
	
		$ kubectl describe rs
	
		$ kubectl get rs -o wide
	
		$ kubectl get rs -o yaml
	
	
- **Secrets:**

		$ kubectl get secrets
	
		$ kubectl get secrets --all-namespaces
	
		$ kubectl get secrets -o yaml


- **ConfigMaps:**

		$ kubectl get configmaps 

		$ kubectl get cm --all-namespaces

		$ kubectl get cm --all-namespaces - o yaml

- **Ingress:**
		
		$ kubectl get ingress

		$ kubectl get ing --all-namespaces

- **PV/PVC:**

		$ kubectl get pv|pvc

		$ kubectl describe pv|pvc

- **Logs:**

		$ kubectl logs [pod_name]

		$ kubectl logs --since=1h [pod_name]

		$ kubectl logs --tail=20 [pod_name]

		$ kubectl logs -f -c [container_name] [pod_name]

		$ kubectl logs [pod_name] > pod.log


## Modificar/Eliminar atributos de los recursos

- **Nodos:**

		$ kubectl edit node [node-name]

		$ kubectl delete node [node-name]


- **Pods:**

		$ kubectl edit pod [pod-name]

		$ kubectl delete pod [pod-name]


- **Deployments:**

		$ kubectl edit deploy [deploy-name]

		$ kubectl delete deploy [deploy_name]

		$ kubectl expose deploy [deploy_name] --port=80 --type=NodePort

		$ kubectl scale deploy [deploy_name] --replicas=5


- **Namespaces:**

		$ kubectl delete ns  

		$ kubectl edit ns [ns_name]

- **ServiceAccounts:**

		$ kubectl edit sa [sa_name]

		$ kubectl delete sa [sa_name]	
	
	
## Crear recursos

- **Crear Pod:**

		$ kubectl create -f [file] 

		$ kubectl apply -f [file]

		$ kubectl run [pod_name] --image=nginx --restart=Never


- **Crear/Exponer Service:**
	
		$ kubectl create svc nodeport [svc_name] --tcp=8080:80

		$ kubectl expose -f file.yaml --port=80 --target-port=8080


- **Crear deployment:**

		$ kubectl create -f [deploymentfile]

		$ kubectl apply -f [deploymentfile]	

		$ kubectl create deploy [deploy_name] --image nginx


- **Crear pod interactivo:**

		$ kubectl run [pod_name] --image=busybox --rm -it --restart=Never -- /bin/bash

-- **Crear fichero mediante output yaml:**

		$ kubectl create deploy  [deploy_name] --image=nginx --dry-run -o yaml > deploy.yaml

		$ kubectl get po [pod_name] -o yaml --export > pod.yaml
	
## Info cluster
		
		$ kubectl config

		$ kubectl cluster -info

		$ kubectl get componentstatuses



## Help	
		
		$ kubectl -h 

		$ kubectl  create - h$

		$ kubectl run - h

		$ kubectl explain deploy.spec
		
