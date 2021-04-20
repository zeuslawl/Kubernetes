# Indice 

·[Introducción](#Introducción)

·[¿Qué es Kubernetes?](#quees)

·[Arquitectura](#arquitectura)
		
	- [Componentes](#componentes)

		- [Master](#master)

			-[API-server](#api)
			
			-[Scheduler](#scheduler)

			-[Controller-manager](#controller)

			-[etcd](#etcd)				

		- [Workers](#workers)
				
			-[Kubetet](#kubelet)

			-[Container-runtime](#containerruntime)

			-[Kube Proxy](#kubeproxy)

·[Elementos de Kubernetes](#elementos)

	- [Pods](#pods)

	- [Nodes](#nodes)

	- [Clusters](#clusters)

	- [Volumes](#volumes)

	- [Deployments/Statefulsets](#deployments)

	- [Tags & selectors](#tags)

	- [Service & Endpoints](#services)

	- [ConfigMap](#configmaps)

	- [DNS](#dns)
 

·[Instalación en entorno de pruebas](#Instalación)


[Bibliografía](#biblio) 


# Introducción<a name="introduccion"></a>

Somos Roberto Martínez y Alejandro López, dos alumnos de (Hisix2) Administración y sistemas en red.

Hemos seleccionado kubernetes para nuestro proyecto final porque creemos que tiene mucho potencial en la virtualización y alta disponibilidad y nos puede servir en nuestra vida laboral.


# ¿Qué es Kubernetes?<a name="quees"></a>

Kubernetes es una plataforma portable y extensible de código abierto para administrar cargas de trabajo y servicios.
Kubernetes facilita la automatización y la configuración declarativa. Tiene un ecosistema grande y en rápido crecimiento. El soporte, las herramientas y los servicios para Kubernetes están ampliamente disponibles.

Google liberó el proyecto Kubernetes en el año 2014. Kubernetes se basa en la experiencia de Google corriendo aplicaciones en producción a gran escala por década y media, junto a las mejores ideas y prácticas de la comunidad.




# Arquitectura<a name="arquitectura"></a>

https://kubernetes.io/es/docs/concepts/architecture/

texto arquitectura 


# Instalación de entorno de pruebas<a name="Instalación"></a>
Necesitamos **docker**, **kubectl** y **minikube**.

**kubectl** Aplicación que gestiona kubernetes

**minikube** Entorno de pruebas para aprender kubernetes, crea un cluster de nodos donde se pueden hacer todo tipo de pruebas.


Tutorial interactivo - crear un clúster


# Bibliografía<a name="bibliografia"></a>

[Arquitectura](https://kubernetes.io/es/docs/concepts/architecture/)

[Crear un cluster](https://kubernetes.io/es/docs/tutorials/kubernetes-basics/create-cluster/)

[Web editor md](https://stackedit.io/app#)

[explicación](https://www.itshellws.org/kubernetes/)

[Componentes arquitectura](https://aprenderdevops.com/arquitectura-de-kubernetes/)

[pdf universidad](https://core.ac.uk/download/pdf/288501998.pdf)
