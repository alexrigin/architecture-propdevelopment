#!/bin/bash

# команда для старта minikube
# minikube start --driver=docker --network-plugin=cni --cni=calico

# Создаем namespace
kubectl create namespace for-task

# Создаем поды
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: front-end
  namespace: for-task
  labels:
    app: front-end
    role: front-end
spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
---
apiVersion: v1
kind: Pod
metadata:
  name: back-end-api
  namespace: for-task
  labels:
    app: back-end-api
    role: back-end-api
spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
---
apiVersion: v1
kind: Pod
metadata:
  name: admin-front-end
  namespace: for-task
  labels:
    app: admin-front-end
    role: admin-front-end
spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
---
apiVersion: v1
kind: Pod
metadata:
  name: admin-back-end-api
  namespace: for-task
  labels:
    app: admin-back-end-api
    role: admin-back-end-api
spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
EOF

# Создаем сервисы для Pod-ов
for app in front-end back-end-api admin-front-end admin-back-end-api; do
  kubectl expose pod $app --namespace=for-task --port=80
done

# применение политики
kubectl apply -f non-admin-api-allow.yaml

echo "Установка завершена. Для проверки:"
echo "kubectl run test-$RANDOM --rm -i -t --image=alpine --namespace="for-task" --labels="app=front-end" -- sh"
echo "kubectl run test-$RANDOM --rm -i -t --image=alpine --namespace="for-task" --labels="app=admin-front-end" -- sh"
echo "wget -qO- --timeout=2 http://back-end-api"
echo "wget -qO- --timeout=2 http://admin-back-end-api"