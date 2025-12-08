| Роль               | Права роли                                               | Группы пользователей               |
|--------------------|----------------------------------------------------------|------------------------------------|
| read-secrets       | resources: ["secrets"] verbs: ["get", "list"]            | devops, infrastructure-operator    |
| cluster-pod-reader | resources: ["pods"] verbs: ["get", "list", "watch"]      | developer, infrastructure-operator |
| cluster-pod-editor | resources: ["pods"] verbs: ["create", "update", "patch"] | devops                             |
