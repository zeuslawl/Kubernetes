
## CLUSTER

- ¿qué es?

- manera de implementar un clúster

![](../images/archi_cluster.png)


## NODES

- ¿qué es un node?

- Master node (control-plane)

	- definición y funciones

	- procesos:

		- API server

		- Scheduler

		- Controller-manager

		- Etcd

- Worker node 

	- funciones

	- procesos

		- container runtime

		- kubelet

		- kube-proxy

![](../images/archi3.png)

## PODS

- definición

- ip + puerto

- acceso a volúmenes compartidos

- uso

![](../images/archi_pods2.png)

---

# NAMESPACES

- Definición

- agrupar, entornos

- 3 namespaces por defecto

- crear namespaces

![](../images/namespaces.jpg)

---

# CONFIGMAPS

![](../images/configmap.png)

---

[](../images/secret.jpg)

---



# RBAC

- Definición y uso

- Usuarios: como crearlos

- Permisos:

	- Role

	- ClusterRole

	- RoleBinding

	- ClusterRoleBinding

![](../images/rbac_diapo)



