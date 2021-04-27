**¿Qué es?**

Kubernetes (timonel o piloto en griego) es un software de orquestación de código abierto que permite implementar, administrar y escalar aplicaciones en  unidades lógicas para gestionarlas y darles visibilidad. 
Tiene un ecosistema grande y en rápido crecimiento. El soporte, las herramientas y los servicios para Kubernetes están ampliamente disponibles.
Kubernetes ofrece un entorno de administración centrado en contenedores, orquesta la infraestructura de cómputo, redes y almacenamiento para que las cargas de trabajo de los usuarios no tengan que hacerlo.
Fue diseñado por Google en 2014 y su diseño estuvo influenciado por el proyecto Borg y donado a la Cloud Native Foundation.

**¿Qué ofrece?** 

Las principales carácterísticas de K8s son las siguientes:

- **Escalado vertical.** En función del uso de CPU que hagamos Kubernetes nos permite el escalado vertical de nuestras aplicaciones de manera automática (autoescalado) o manual (comando).

- **Reparación automática.** En caso de ocurrir un fallo en un contenedor podemos reiniciar automáticamente, así como reemplazarlo o replanificarlo cuando un nodo muere. También nos ofrece la posibilidad de reparar aquellos health checks definidos por el usuario que no respondan.

- **Planificación de nodos y contenedores.** Kubernetes nos ayuda a decidir en qué nodo se ejecutará cada contenedor, en función de los recursos necesarios y otras restricciones. Además, podemos mezclar cargas de trabajo críticas y best-effort con el objetivo de potenciar el ahorro de recursos.

- **Despliegues y rollbacks automáticos.** Podemos desplegar los cambios de manera progresiva cuando actualizamos una aplicación o cambiamos su configuración, y así poder realizar un rollback automático en caso de fallo en alguna de las instancias.

- **Orquestador de contenedores.** Kubernetes permite montar de forma automática el sistema de almacenamiento necesario para los contenedores: en modo local, en un proveedor de cloud pública, o en un sistema de red como NFS, Flocker o Gluster.

- **Almacenamiento persistente.** K8s goza de soporte en plataformas como Amazon Web Services o Google Cloud Platform, y los proveedores (Red Hat, Dell EMC, NetApp, etc) le proporcionan almacenamiento persistente.

- **Descubrimiento de servicios.** Con Kubernetes asignamos a los contenedores sus propias direcciones IP y un nombre DNS específico para cada conjunto de contenedores. Así, no resulta necesario utilizar recursos externos para el descubrimiento de servicios.

- **Seguridad.** Toda nuestra información sensible, como contraseñas o claves ssh, podemos almacenarla de manera segura en secrets. En este sentido, Kubernetes no expone nuestra información confidencial a la hora de desplegar y configurar nuestras aplicaciones.

- **Clusters grandes y heterogéneos.** Kubernetes puede desplegarse en clusters muy grandes, incluyendo contenedores Docker. Por otro lado, nos permite crear un clúster como resultado de combinar diferentes máquinas virtuales o servidores locales.