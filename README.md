# Proyecto Kubernetes – Implementación de Sitio Web Estático

## Descripción
Este proyecto tiene como objetivo desplegar una página web estática en un entorno Kubernetes local mediante Minikube. Se utilizan distintos recursos de Kubernetes, incluyendo Namespace, ConfigMap, PersistentVolume, PersistentVolumeClaim, Deployment y Service para lograr el despliegue.

________________________________________

## Requisitos
- Git
- Minikube
- kubectl
- Docker instalado en la máquina

________________________________________

## Guía para Reproducir el Entorno

### 1. Clonación de Repositorios

#### Página Web Estática
Clona el repositorio que contiene la web:
* `git clone https://github.com/JuliettaSh/static-website.git`

#### Manifiestos de Kubernetes
Clona también el repositorio que reúne los archivos de configuración:
* `git clone https://github.com/JuliettaSh/Manifiestos.git`

### 2. Inicialización de Minikube

Arranca Minikube utilizando un perfil personalizado y asegúrate de activar el metrics-server:
* `minikube start -p 0311at --addons=metrics-server`

### 3. Despliegue de los Manifiestos

Desde el repositorio con los manifiestos, aplica los recursos en el siguiente orden:

1. Crear el PersistentVolume:
   * `kubectl apply -f volumes/pv.yaml`
2. Crear el PersistentVolumeClaim:
   * `kubectl apply -f volumes/pvc.yaml`
3. Desplegar la aplicación web mediante el Deployment:
   * `kubectl apply -f deployments/web-deployment.yml`
4. Configurar el Service que expondrá la aplicación:
   * `kubectl apply -f services/web-service.yml`

> **Importante:** Asegúrate de estar trabajando en el contexto y namespace adecuados.

### 4. Exposición del Servicio

Para acceder a la página web, utiliza el siguiente comando, el cual utiliza el perfil y namespace configurados:
* `minikube service web-service -p 0311at`

Este comando abrirá la aplicación en tu navegador de manera local.

