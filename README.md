# Proyecto Kubernetes – Implementación de Sitio Web Estático

## Descripción
Con esto vas a poder instalar un sitio web en un cluster de KS8 (Kubernetes)
esto tiene los siguientes recursos para poder desplegar la pagina.
Cabe recalcar que necesitas al menos un conocimiento basico de manejo de kubernetes 

- Namespace
- PersistentVolume
- Persistent volume claim
- Deployment
- Service

## Asegurate de contar con lo siguiente instalado en la maquina:
- Git: Para clonar y versionar los repos
- Minikube: Para levantar el cluster que va a tener kubernetes local
- Kubectl: Para interactuar con el cluster
- Docker: Necesario para la construccion y ejecucion de contenedores
________________________________________

## Paso a paso 

#### 1) Página Web Estática
Clona el repositorio este tiene la web estatica donde se va a desplegar para verlo desde el cluster:
* `git clone https://github.com/facundoh3/static-website.git`

#### 2) Manifiestos de Kubernetes
Clona también el repo que reúne los archivos de configuración para que los puedas aplicar para levantar todo:
* `git clone https://github.com/facundoh3/Manifiestos.git`

#### 3) Arranca el Minikube utilizando un perfil personalizado y asegúrate de activar el metrics-server:
* `minikube start -p 0311at --addons=metrics-server`

Bueno en este punto ya tenes todo clonado ahora te tenes que ir a la carpeta donde estan los Manifiestos para poder aplicarlos 
cd ManifestScripts

despues de esto vas a poder crear cada recurso para desplegarlo 

1. Crea el persistent volume:
   * `kubectl apply -f volumes/pv.yaml`
2. Crea el persistent volume claim:
   * `kubectl apply -f volumes/pvc.yaml`
3. Ejecuta el deployment:
   * `kubectl apply -f deployments/web-deployment.yml`
4. Aplica el service que ese es el que va a exponer la app
   * `kubectl apply -f services/web-service.yml`


#### 4. Exposición del Servicio
Aca vas a tener que poner el nombre del perfil que creaste en el paso 3 en este caso "0311at" con el nombre del deployment para que arranque
* `minikube service web-service -p 0311at`

Esto va a abrir la pagina de manera local 

