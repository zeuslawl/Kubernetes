
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


---------------------------------------------------------------------------------
--------------------------------------------------------------------------------
https://onthedock.github.io/post/170414-error_the-connection-to-the-server-was-refused/

https://www.ochobitshacenunbyte.com/2020/01/27/como-generar-uuid-para-interfaz-de-red-en-rhel-y-centos/


# Instalación
En este ejemplo de instalación se muestra como instalar un cluster de tres máquinas,
 un master ( control-plane ) y dos workers, 
esta instalación se realiza en máquinas virtuales fedora32 
y la tipología del master es stacked.

### Preparación de nodos
Asignar hostname a cada nodo

hostnamectl set-hostname master
hostnamectl set-hostname node1
hostnamectl set-hostname node2


### Deshabilitar swap

swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab

### Resolución de nombres

127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.122.2 master
192.168.122.3 node1
192.168.122.4 node2

### Ip fijas (para cada nodo)
[root@master ~]# cat /etc/sysconfig/network-scripts/ifcfg-enp1s0 
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=enp1s0
UUID=933cd398-b601-4406-ba4c-6a5bf8106bdc
ONBOOT=yes
AUTOCONNECT_PRIORITY=-999

BOOTPROTO=none
DEVICE=enp1s0
IPADDR=192.168.122.2
NETMASK=255.255.255.0
GATEWAY=192.168.122.1
DNS1=192.168.


### Deshabilitar firewalld y habilitar forwarding
systemctl stop firewalld
systemctl disable firewalld

	# Enable IP Forwarding
	echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
	cat <<EOF >  /etc/sysctl.d/k8s.conf
	net.bridge.bridge-nf-call-ip6tables = 1
	net.bridge.bridge-nf-call-iptables = 1
	EOF

Si nos da este problema
	cannot stat /proc/sys/net/bridge/bridge-nf-call-iptables: No existe el fichero o el directorio


# SOLUCIÓN
[root@node1 ~]#	modprobe br_netfilter
[root@node1 ~]# sysctl -p
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1


### Instalar servicios
En todos los nodos es necesario instalar docker, kubelet, kubectl, kubeadm.

### Instalación de docker
https://docs.docker.com/engine/install/fedora/

Instalación de kubeam, kubectl, kubelet

# añadir repositorio de kubernetes
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# instalar servicios y habilitar kubelet (Fedora 32)
dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet


[root@master ~]# kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.0", GitCommit:"cb303e613a121a29364f75cc67d3d580833a7479", GitTreeState:"clean", BuildDate:"2021-04-08T16:30:03Z", GoVersion:"go1.16.1", Compiler:"gc", Platform:"linux/amd64"}



Creación de master
En la creación del master hay que tener en que red se crearan los Pods, esta opción kubernetes lo deja en addons externos, puedes elegir entre diferentes opciones que encontrarás en este documento. En esta instalación se asignara el addon calico.

Nota: El dns del cluster CoreDNS no se iniciará si no hay antes una red de Pods instalada.

Iniciar configuración del master con red de pod

kubeadm init --pod-network-cidr=192.168.0.0/16

Este comando descarga imágenes que necesita el cluster para funcionar y tarda un rato en completarse.


El comando anterior acaba mostrando las siguientes instrucciones a realizar, 
para la finalización de la instalación del master.

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.122.2:6443 --token c2bn4c.qzpskak8ryp1uotd \
	--discovery-token-ca-cert-hash sha256:485a9c649a4d2a4ad9ec03932f6353fc559a1a60dbf1fe00bf71d8e57c6b6b83 


NOTA: Es muy importante guardarse bien la línea de kubeadm join ya que con esta juntaremos los nodos al master.


En caso de no querer gestionar el cluster como root, y quererlo gestionar como usuario.
[master@master ~]$ mkdir -p $HOME/.kube
[master@master ~]$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
[master@master ~]$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

Aplico el addon para gestionar las redes de Pods
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml


Juntar nodos worker
Para juntar un worker al nodo master simplemente hay que ejecutar kubeadm join con el token del master.

kubeadm join 192.168.122.2:6443 --token c2bn4c.qzpskak8ryp1uotd \
	--discovery-token-ca-cert-hash sha256:485a9c649a4d2a4ad9ec03932f6353fc559a1a60dbf1fe00bf71d8e57c6b6b83 

Si esta opción muestra algún error, es posible que el firewall del master este rechazando la conexión, comprobar los puertos accesibles por el firewall.
En caso de no disponer del token, siempre se puede crear uno nuevo desde el master con kubeadm token create --print-join-command


Ahora desde el master se puede ver que el nodo se a añadido al master, es una buena practica asignarle algún label al nodo, para identificar que modo de nodo es y por si se quieren asignar pods específicos al nodo.

#nodo recien añadido
[root@master ~]# kubectl get nodes
NAME     STATUS   ROLES                  AGE   VERSION
master   Ready    control-plane,master   68m   v1.21.0
node1    Ready    <none>                 66s   v1.21.0

Añadir nodo como worker
[root@master ~]# kubectl label node node1 node-role.kubernetes.io/worker=worker node/node1 labeled

[root@master ~]# kubectl get nodes
NAME     STATUS   ROLES                  AGE     VERSION
master   Ready    control-plane,master   71m     v1.21.0
node1    Ready    worker                 3m59s   v1.21.0


[root@master ~]# kubectl label nodes node1 node=worker1
node/node1 labeled

[root@master ~]# kubectl get nodes --show-labels
NAME     STATUS   ROLES                  AGE     VERSION   LABELS
master   Ready    control-plane,master   74m     v1.21.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=master,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node-role.kubernetes.io/master=,node.kubernetes.io/exclude-from-external-load-balancers=
node1    Ready    worker                 6m26s   v1.21.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node1,kubernetes.io/os=linux,node-role.kubernetes.io/worker=worker,node=worker1

Eliminar un nodo
Desde el nodo master drenar el nodo que queremos eliminar, una vez drenado de todas sus tareas eliminarlo.

		kubectl drain <node name> --delete-local-data --force --ignore-daemonsets
		kubectl delete node <node name>

En el nodo que se a eliminado del cluster restablecer la configuración inicial
		kubeadm reset

El proceso de reinicio no reinicia ni limpia las reglas de iptables o las tablas de IPVS. Si desea restablecer iptables, debe hacerlo manualmente:

		iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

Si desea restablecer las tablas IPVS, debe ejecutar el siguiente comando:

		ipvsadm -C


























































