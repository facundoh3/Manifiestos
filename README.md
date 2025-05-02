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

#### 3) Arranca el script que esta dentro de la carpeta ManifestScripts con bash deployment.sh 

* Enjoy *
