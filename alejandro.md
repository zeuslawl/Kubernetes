Instalar minikube 

https://v1-17.docs.kubernetes.io/docs/tasks/tools/install-minikube/

https://blog-es.mimacom.com/introduccion-kubernetes-minikube/

Install minikube via direct Download

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
  
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

Comprobar 
minikube status

A
minikube start


BORRAR PV 
kubectl delete pv nombre_pv
kubectl delete pv mysql-pv


-------------------------------------------------
AÑADIR A DOCUMENTACIÓN

# Instalación de entorno de pruebas<a name="instalacion"></a>

## Requisitos:<a name="requisitos"></a>

- Sistema operativo:
	- Ubuntu 16.+
	- Debian 9+
	- CentOS 7+
	- Red Had Enterprise Linux (RHEL)7
	- Fedora25+
	- HypriotOS v1.0.1+
	- etc.

- 2GB mínimo de RAM para el masters nodes
- 1GB mínimo de RAM para workers nodes
- 2 CPUs mínimo



Necesitamos tener instalado previamente **docker** para poder trabajar en Kubernetes.

Debemos instalar: 

- **kubectl** Aplicación que gestiona kubernetes

- **kubeadm**

- **kubelet**

- **minikube** Entorno de pruebas para aprender kubernetes, crea un cluster de nodos donde se pueden hacer todo tipo de pruebas.

		# dnf -y install kubeadm kubelet kubectl

## Instalar Minikube en Fedora 32

Para trabajar con ambientes de Kubernetes normalmente es más sencillo poder instalar 
un cluster local en nuestro equipo que nos permita probar de una forma más expedita sin 
tener que interactuar con un servidor externo. Una de las herramientas que nos sirve 
para esta tarea es Minikube.

### Prerequisitos

Para instalar Minikube, se debe validar los siguientes requisitos:

**Validar que la virtualización está soportada en el linux**

		# grep -E --color 'vmx|svm' /proc/cpuinfo

**Tener instalado Kubectl**

		# kubectl version --client 

Si no lo tenemos instalado, lo instalamos.

Para instalar Kubectl vamos a habilitar un YUM repo de Google e instalar el paquete kubectl.

		# sudo tee /etc/yum.repos.d/kubernetes.repo<<EOF
		 [kubernetes]
		 name=Kubernetes
		 baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
		 enabled=1
		 gpgcheck=1
		 repo_gpgcheck=1
		 gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
		 EOF

		sudo dnf makecache

		sudo dnf install kubectl 

**Tener instaldo un hipervisor**

Se requiere tener instalado un hipervisor, el Minikube soporta varios pero en este caso
vamos a instalar KVM. Para revisar si lo tenemos instalado podemos validar si está 
habilitado el módulo en el Kernel ejecutando el comando:

		# lsmod | grep kvm


En caso de no tenerlo instalado, lo instalamos.

Para instalarlo, vamos a instalar los siguientes paquetes:

		# Instala el KVM
		sudo dnf install bridge-utils libvirt virt-install qemu-kvm

		# Otras herramientas útiles para el KVM
		sudo dnf install virt-top libguestfs-tools

		# Habilita el servicio
		sudo systemctl enable --now libvirtd

		# Instala un administrador gráfico
		sudo dnf install virt-manager

		# Agrega nuestro usuario al grupo del KVM
		sudo usermod -a -G libvirt $(whoami)

### Instalación de Minikube

		# Descarga el binario y le asigna permisos de ejecución
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  			&& chmod +x minikube

		# Intenta crear esta ruta en caso de que no exista
		sudo mkdir -p /usr/local/bin/

		# Instala el binario del minikube en la ruta
		sudo install minikube /usr/local/bin/

		# Elimina el binario descargado
		rm minikube

Para probar si todo se instaló bien, podemos crear un cluster de Minikube usando KVM con
los siguientes comandos:

		# Crear un cluster de minikube (default)
		minikube start --driver=kvm2

		# Pregunta por el estado
		minikube status

		# Elimina el minikube que se creó para probar
		minikube delete		

Por defecto va a crear un cluster de un nodo con la última versión disponible de Kubernetes,
el nodo se le asignarán los recursos:

* vCPU = 2
* Memoria = 6000MB
* Disco = 20000MB

### Crear un cluster minikube personalizado

Con el siguiente comando podemos crear un cluster personalizado de 4 vCPUs, 4 GB de memoria RAM
y 20GB de disco duro, usando la versión 1.17.6 de Kubernetes.

		# Muestra información de los parámetros disponibles para el start
		minikube help start

		# Crea minikube personalizado
		minikube start --driver=kvm2 \
		  --cpus=4 \
		  --memory=4096 \
		  --disk-size=20000mb \
		  --kubernetes-version=1.17.6

Para calcular la memoria RAM, 1024 * los GB que queramos 
Ejemplo de 4GB de memoria RAM

	1024*4= 4096


# CLUSTER REAL

PASOS 

DESDE MASTER
cat /etc/hosts

172.16.125.146 kubemaster01.tunetolinux.com kubemaster01
172.16.125.145 minions01.tunetolinux.com minions01

sestatus
		disabled

systemctl status firewalld 

DISABLED

vi /etc/yum.repos.d/kubernetes.repo

poner la baseurl.. etc

yum install -y kubeadm docker

systemctl start kubelet
		  enable
systemctl start docker
		  enable

DESACTIVAR SWAP
vi /etc/fstab
comentamos la linea de swap

swapoff -a 

free -h 
vemos que no tenemos swap

vim /etc/sysctl.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1

sysctl -p

kubeadm init --pod-network-cidr=172.30.0.0/16

TE CREA EL MASTER

hacer comandos de sudo cp 
sudo chown

kubectl get nodes

kubectl get nodes -o wide

kubectl get pods
no deberia salir ni uno

kubectl get pods --all-namespaces

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml




RESUMEN PASOS

1. Install packages on master and minions
yum install kubeadm docker -y

2. Stop firewall/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

3. Start docker and kubelet service
for i in kubelet docker; do systemctl start $i; systemctl enable $i;systemctl status $i; done

4. Ensure swap is off and comment in fstab
swapoff -a

5. Enable IP forwarding or iptables. Update below lines in /etc/sysctl.conf

net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1

6. To take effect the new kernel paramater settings:
sysctl -p

7. Set IP range for pods or docker container:
kubeadm init --pod-network-cidr=172.30.0.0/16

8. mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

9. Configure flannel networking for your docker containner.
kubectl apply -f https://raw.githubusercontent.com/cor...


https://youtu.be/w5K_fUcg8qQ

























































