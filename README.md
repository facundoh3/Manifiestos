
### Despliegue del entorno de pagina web en minikube

**Requisitos solicitados:**
- Minikube instalado y funcionando
- Git instalado y funcionando

**Pasos a seguir:**

1) Iniciar minikube con su perfil deseado y habilitar los addons necesarios:
   dashboard, ingress, metrics-server
   ```jsx
	minikube start -p aca-va-tu-perfil --addons=metrics-server,dashboard,ingress
	```
2) Clona los siguientes repositorios 
   - Contenido web:  
     ```git clone https://github.com/facundoh3/PaginaEstatica.git``` 
   - Manifiestos Kubernetes:
     ```git clone https://github.com/facundoh3/Manifiestos```