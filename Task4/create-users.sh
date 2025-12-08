#!/bin/bash

cat <<EOF | kubectl apply -f -
# создание пользователя 1
apiVersion: v1
kind: ServiceAccount
metadata:
  name: developer
  namespace: default
---
# создание пользователя 2
apiVersion: v1
kind: ServiceAccount
metadata:
  name: devops
  namespace: default
---
# создание пользователя 3
apiVersion: v1
kind: ServiceAccount
metadata:
  name: infrastructure-operator
  namespace: default

EOF






