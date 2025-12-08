#!/bin/bash

cat <<EOF | kubectl apply -f -

#bind read-secrets for devops
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: devops-read-secrets
  namespace: default
subjects:
- kind: ServiceAccount
  name: devops
roleRef:
  kind: Role
  name: read-secrets
  apiGroup: rbac.authorization.k8s.io
---
#bind read-secrets for infrastructure-operator
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: infrastructure-operator-read-secrets
  namespace: default
subjects:
- kind: ServiceAccount
  name: infrastructure-operator
roleRef:
  kind: Role
  name: read-secrets
  apiGroup: rbac.authorization.k8s.io
---
#bind cluster-pod-reader for infrastructure-operator
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: infrastructure-operator-cluster-read-pods
subjects:
- kind: ServiceAccount
  name: infrastructure-operator
  namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-pod-reader
  apiGroup: rbac.authorization.k8s.io
---
#bind cluster-pod-reader for developer
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: developer-cluster-read-pods
subjects:
- kind: ServiceAccount
  name: developer
  namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-pod-reader
  apiGroup: rbac.authorization.k8s.io
---
#bind cluster-pod-editor for devops
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: devops-cluster-edit-pods
subjects:
- kind: ServiceAccount
  name: devops
  namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-pod-editor
  apiGroup: rbac.authorization.k8s.io
EOF
