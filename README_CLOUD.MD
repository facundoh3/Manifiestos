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

#### IMPORTANTE:
Ahora cuando haces cambios en la pagina (Index) tenes que volver a desplegar el deployment (borrarlo y volverlo a poner) o hacer un rollout  
- `kubectl rollout restart deployment/web-deployment.yml` esto es para el rollout
Despues tenes que volver que lanzar el service como en el paso 4

**Si los cambios no se ven, no te preocupes solamente recarga la pagina y los cambios se veran reflejados**



