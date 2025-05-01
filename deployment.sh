#!/usr/bin/env bash
set -euo pipefail

[ -f config.env ] && source config.env
: "${MANIFESTS_DIR:="."}"
: "${PROFILE:="0311at"}"

cd "$MANIFESTS_DIR"

if minikube status -p "$PROFILE" | grep -q 'host: Running'; then
  echo "Reutilizando el perfil ($PROFILE)"
else
  echo "Iniciando en el perfil($PROFILE)…"
  minikube start -p "$PROFILE"
fi


#Esto no lo sabia como hacer asique le pregunte al chat
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

kubectl rollout status deployment/web-static-deployment --timeout=60s

echo "URL del servicio:"
minikube service web-service -p "$PROFILE" --url

echo "Si cambias el contenido volve a ejecutar ./deployment.sh"
echo '  (\\ /)'
echo '  ( . .)'
echo '  (" )( ")'
