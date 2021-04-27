# INTRODUCCIÓN

## **¿Qué es Kubernetes?**

Kubernetes (timonel o piloto en griego) es un software de orquestación de código abierto que permite implementar, administrar y escalar aplicaciones en  unidades lógicas para gestionarlas y darles visibilidad. 
Tiene un ecosistema grande y en rápido crecimiento. El soporte, las herramientas y los servicios para Kubernetes están ampliamente disponibles.
Kubernetes ofrece un entorno de administración centrado en contenedores, orquesta la infraestructura de cómputo, redes y almacenamiento para que las cargas de trabajo de los usuarios no tengan que hacerlo.
Fue diseñado por Google en 2014 y su diseño estuvo influenciado por el proyecto Borg y donado a la Cloud Native Foundation.

## **¿Qué ofrece?** 

Las principales carácterísticas de K8s (abreviatura de Kubernetes) son las siguientes:

- **Escalado vertical.** En función del uso de CPU que hagamos Kubernetes nos permite el escalado vertical de nuestras aplicaciones de manera automática (autoescalado) o manual (comando).

- **Reparación automática.** En caso de ocurrir un fallo en un contenedor podemos reiniciar automáticamente, así como reemplazarlo o replanificarlo cuando un nodo muere. También nos ofrece la posibilidad de reparar aquellos health checks definidos por el usuario que no respondan.

- **Planificación de nodos y contenedores.** Kubernetes nos ayuda a decidir en qué nodo se ejecutará cada contenedor, en función de los recursos necesarios y otras restricciones. Además, podemos mezclar cargas de trabajo críticas y best-effort con el objetivo de potenciar el ahorro de recursos.

- **Despliegues y rollbacks automáticos.** Podemos desplegar los cambios de manera progresiva cuando actualizamos una aplicación o cambiamos su configuración, y así poder realizar un rollback automático en caso de fallo en alguna de las instancias.

- **Orquestador de contenedores.** Kubernetes permite montar de forma automática el sistema de almacenamiento necesario para los contenedores: en modo local, en un proveedor de cloud pública, o en un sistema de red como NFS, Flocker o Gluster.

- **Almacenamiento persistente.** K8s goza de soporte en plataformas como Amazon Web Services o Google Cloud Platform, y los proveedores (Red Hat, Dell EMC, NetApp, etc) le proporcionan almacenamiento persistente.

- **Descubrimiento de servicios.** Con Kubernetes asignamos a los contenedores sus propias direcciones IP y un nombre DNS específico para cada conjunto de contenedores. Así, no resulta necesario utilizar recursos externos para el descubrimiento de servicios.

- **Seguridad.** Toda nuestra información sensible, como contraseñas o claves ssh, podemos almacenarla de manera segura en secrets. En este sentido, Kubernetes no expone nuestra información confidencial a la hora de desplegar y configurar nuestras aplicaciones.

- **Clusters grandes y heterogéneos.** Kubernetes puede desplegarse en clusters muy grandes, incluyendo contenedores Docker. Por otro lado, nos permite crear un clúster como resultado de combinar diferentes máquinas virtuales o servidores locales.

---

# ARQUITECTURA

![](images/archi3.png)

## **Clúster**

Un clúster de Kubernetes es un conjunto de máquinas de nodos que ejecutan aplicaciones en contenedores. Si ejecuta Kubernetes, está ejecutando un clúster.

Como mínimo, un clúster contiene un plano de control y una o varias máquinas informáticas o nodos. El control plane es el encargado de mantener el estado deseado del clúster y de controlar, por ejemplo, las aplicaciones que se ejecutan y las imágenes de contenedores que se utilizan. Los nodos son los que realmente ejecutan las aplicaciones y las cargas de trabajo.

La ventaja más importante de Kubernetes es la capacidad de programar y ejecutar contenedores en un grupo de máquinas, ya sean físicas o virtuales, en local o en un cloud, y esto es posible gracias al clúster. Los contenedores de Kubernetes no están ligados a ninguna máquina individual. De hecho, están aislados en el clúster.

Podemos crear clusters en local, en el cloud, híbridos y también minikube, virtualización de un cluster en un solo nodo virtual que se utiliza para hacer tests y que luego explicaremos con más detalle.



## **Nodos**

![](images/archi_cluster.png)

Un nodo es una máquina de trabajo en Kubernetes, previamente conocida como minion. Un nodo puede ser una máquina virtual o física, dependiendo del tipo de clúster. Hay dos tipos de nodos: master o control plane y workers. Cada uno de ellos ejecuta diferentes procesos según su clasificación:

- ### **Node master:**

	Aquí se encuentran los elementos de Kubernetes que controlan el clúster, junto con los datos sobre su estado y configuración. Los elementos principales de Kubernetes tienen la importante tarea de garantizar que los contenedores se ejecuten en cantidades suficientes y con los recursos necesarios. 
	El plano de control está en contacto permanente con las máquinas informáticas. Garantiza que el clúster se ejecute según la configuración que hayamos elegido.
	Consta de diferentes procesos:

	· **API-Server:**
	Es el componenete que interactúa con el cliente. Se trata del frontend de Kubernetes, recibe las peticiones y actualiza acordemente el estado en etcd.

	· **Scheduler:**
	Este proceso se encarga de decidir en qúe nodo se ejecutaran los pods. Para ello tiene en cuenta los siguientes factores: requisitos de recursos, restricciones de hardware/software/políticas, afinidad y anti-afinidad, localización de datos dependientes, entre otros.

	· **Controller-manager:**
	Es el componente que ejecuta los controles de k8s. Cada controlador es un proceso independiente, pero para reducir la complejidad, todos se compilan en un único binario y se ejecuta en un mismo proceso. Estos controladores incluyen:

    	- **Controlador de nodo:** es el responsable de detectar y responder cuándo un nodo deja de funcionar.

    	- **Controlador de replicación:** es el responsable de mantener el número correcto de pods para cada controlador de replicación del sistema.
    
    	- **Controlador de endpoints:** construye el objeto Endpoints, es decir, hace una unión entre los Services y los Pods.

    	- **Controladores de tokens y cuentas de servicio:** crean cuentas y tokens de acceso a la API por defecto para los nuevos Namespaces


	· **Etcd:** Es la base de datos donde se guarda toda la información que utiliza el cluster.



- ### **Node worker:**

	El worker node, nos proporcionara un entrono de ejecución para las aplicaciones. Estas aplicaciones que se encuentran contenerizadas en pods y son controladas por los anteriores processos que hemos descrito del Control Plane que se ejecutan en el Master Node.

	· **Container runtime:** es el software responsable de la ejecución y gestión de los contenedores.

	· **Kubelet:** es el agente que se ejecuta en cada nodo de un clúster y se comunica con los componentes del control plane. Recibe las definiciones del pod del API Server e interacciona con el container runtime para ejecutar contenedores asociados al pod.

	· **Kube-proxy:** es la implementación de un proxy de red y balanceador de carga soportando la abstracción del servicio junto con otras operaciones de red. Es responsable del enrutamiento del tráfico hacia el contenedor correcto basado en la dirección IP y el número de puerto indicados por el control plane



## **Pods**

![](images/archi_pods2.png)

Un Pod es un grupo de uno o más contenedores, con almacenamiento/red compartidos, y unas especificaciones de cómo ejecutar los contenedores. Los contenidos de un Pod son siempre coubicados, coprogramados y ejecutados en un contexto compartido. Un Pod modela un "host lógico" específico de la aplicación: contiene uno o más contenedores de aplicaciones relativamente entrelazados.

Los contenedores dentro de un Pod comparten dirección IP y puerto, y pueden encontrarse a través de localhost. También pueden comunicarse entre sí mediante comunicaciones estándar entre procesos. Los contenedores en diferentes normalmente se comunican entre sí a través de las IP's.

Las aplicaciones dentro de un Pod también tienen acceso a volúmenes compartidos, que se definen como parte de un Pod y están disponibles para ser montados en el sistema de archivos de cada aplicación.

Al igual que los contenedores de aplicaciones individuales, los Pods se consideran entidades relativamente efímeras (en lugar de duraderas). Como se explica en ciclo de vida del pod, los Pods se crean, se les asigna un identificador único (UID) y se planifican en nodos donde permanecen hasta su finalización (según la política de reinicio) o supresión. Si un nodo muere, los Pods programados para ese nodo se programan para su eliminación después de un período de tiempo de espera. Un Pod dado (definido por su UID) no se "replanifica" a un nuevo nodo; en su lugar, puede reemplazarse por un Pod idéntico, con incluso el mismo nombre si lo desea, pero con un nuevo UID

Los Pods pueden ser usados para alojar pilas de aplicaciones integradas (por ejemplo, LAMP), pero su objetivo principal es apoyar los programas de ayuda coubicados y coadministrados, como:

   · sistemas de gestión de contenido, loaders de datos y archivos, gestores de caché locales, etc.

   · copia de seguridad de registro y punto de control, compresión, rotación, captura de imágenes, etc.

   · observadores de cambio de datos, adaptadores de registro y monitoreo, publicadores de eventos, etc.

   · proxies, bridges y adaptadores.

   · controladores, configuradores y actualizadores.

Los Pods individuales no están diseñados para ejecutar varias instancias de la misma aplicación, en general.




