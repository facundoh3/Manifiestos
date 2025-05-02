#!/usr/bin/env bash
set -euo pipefail

[ -f config.env ] && source config.env
: "${MANIFESTS_DIR:=.}"
: "${PROFILE:=0311at}"

cd "$MANIFESTS_DIR"

if minikube status -p "$PROFILE" | grep -q 'host: Running'; then
  echo "Reutilizando el perfil ($PROFILE)"
else
  echo "Iniciando en el perfil($PROFILE)…"
  minikube start -p "$PROFILE"
fi

if ! kubectl get pv web-static-pv >/dev/null 2>&1; then
  echo "Aplicando PV y PVC…"
  kubectl apply -f volumes/pv.yml
  kubectl apply -f volumes/pvc.yml
else
  echo "PV/PVC ya existen, no lo voy a hacer de nuevo"
fi

if kubectl get deployment web-static-deployment >/dev/null 2>&1; then
  echo "Actualizando el deployment con rollout-restart"
  kubectl rollout restart deployment/web-static-deployment
else
  echo "Creando el deployment y service"
  kubectl apply -f deployments/web-deployment.yml
  kubectl apply -f services/web-service.yml
fi

kubectl rollout status deployment/web-static-deployment --timeout=120s

echo
POD_NAME=$(kubectl get pods -l app=webapp -o jsonpath='{.items[0].metadata.name}')
echo "> Comprobando el volumen dentro del pod"
if kubectl exec "$POD_NAME" -- sh -c 'mount | grep -q /usr/share/nginx/html'; then
  echo "Volumen montado"
else
  echo "El volumen no está montado en /usr/share/nginx/html" >&2
  exit 1
fi

echo
HTTP_CODE=$(kubectl exec "$POD_NAME" -- sh -c 'curl -s -o /dev/null -w "%{http_code}" http://localhost')
if [ "$HTTP_CODE" -eq 200 ]; then
  echo "La página está siendo servida correctamente en el Pod"
else
  echo "$HTTP_CODE - fallo al servir la página dentro del Pod" >&2
  exit 1
fi

pkill -f "kubectl port-forward svc/web-service 8080:80" >/dev/null 2>&1 || true
kubectl port-forward svc/web-service 8080:80 >/dev/null 2>&1 &
echo "Ingresa a tu sitio en: http://localhost:8080"

echo "Si cambias el contenido volve a ejecutar ./deployment.sh"
echo '  (\ /)'
echo '  ( . .)'
echo '  (" )( ")'
