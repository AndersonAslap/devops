# Kubernetes — Cheat Sheet de Comandos

> Referência rápida de `kubectl`. Sintaxe mínima + finalidade.

## Sumário

1. [Sintaxe geral](#1-sintaxe-geral)
2. [Contexto e configuração](#2-contexto-e-configuração)
3. [Descoberta e documentação](#3-descoberta-e-documentação)
4. [Inspeção de recursos](#4-inspeção-de-recursos)
5. [Criar, aplicar e editar](#5-criar-aplicar-e-editar)
6. [Namespaces](#6-namespaces)
7. [Pods](#7-pods)
8. [Deployments e Rollout](#8-deployments-e-rollout)
9. [ReplicaSets, StatefulSets e DaemonSets](#9-replicasets-statefulsets-e-daemonsets)
10. [Jobs e CronJobs](#10-jobs-e-cronjobs)
11. [Services, Endpoints e Ingress](#11-services-endpoints-e-ingress)
12. [ConfigMaps e Secrets](#12-configmaps-e-secrets)
13. [Volumes e Storage](#13-volumes-e-storage)
14. [Nodes](#14-nodes)
15. [Labels e Annotations](#15-labels-e-annotations)
16. [Autoscaling, recursos e métricas](#16-autoscaling-recursos-e-métricas)
17. [RBAC](#17-rbac)
18. [NetworkPolicy](#18-networkpolicy)
19. [Troubleshooting e Debug](#19-troubleshooting-e-debug)
20. [Gerar manifestos (dry-run)](#20-gerar-manifestos-dry-run)
21. [JSONPath e seletores](#21-jsonpath-e-seletores)
22. [Administração, plugins e proxy](#22-administração-plugins-e-proxy)
23. [Produtividade (completion e alias)](#23-produtividade-completion-e-alias)
24. [Abreviações de recursos](#24-abreviações-de-recursos)
25. [Fluxo básico](#25-fluxo-básico)

---

## 1. Sintaxe geral

```text
kubectl [comando] [tipo] [nome] [flags]
```

```bash
kubectl get pods api-7d8f9c -n production -o yaml
```

| Parte        | Significado          |
| ------------ | -------------------- |
| `kubectl`    | CLI                  |
| `get`        | ação                 |
| `pods`       | tipo de recurso      |
| `api-7d8f9c` | nome do objeto       |
| `-n`         | namespace            |
| `-o yaml`    | formato da saída     |

## 2. Contexto e configuração

```bash
kubectl version                         # Versões cliente/servidor
kubectl cluster-info                    # Informações do cluster
kubectl config view                     # Exibe configuração (kubeconfig)
kubectl config get-contexts             # Lista contexts
kubectl config current-context          # Context atual
kubectl config use-context <ctx>        # Troca de context
kubectl config rename-context <a> <b>   # Renomeia context
kubectl config delete-context <ctx>     # Remove context
kubectl config get-clusters             # Lista clusters
kubectl config set-cluster <name> ...   # Configura cluster
kubectl config set-credentials <name>   # Configura credencial
kubectl config set-context <ctx> ...    # Altera context
kubectl config unset <property>         # Remove propriedade
```

## 3. Descoberta e documentação

```bash
kubectl api-resources                    # Lista recursos da API (e abreviações)
kubectl api-versions                     # Lista versões da API
kubectl explain <resource>               # Documentação do recurso
kubectl explain <resource>.<field>       # Documentação de um campo
kubectl explain <resource> --recursive   # Todos os campos
kubectl options                          # Opções globais
kubectl <command> --help                 # Ajuda do comando
```

## 4. Inspeção de recursos

```bash
kubectl get <resource>                          # Lista recursos
kubectl get <resource> <name>                   # Um recurso específico
kubectl get <resource> -A                       # Todos os namespaces
kubectl get <resource> -n <ns>                  # Namespace específico
kubectl get <resource> -o wide                  # Mais detalhes
kubectl get <resource> -o yaml                  # YAML
kubectl get <resource> -o json                  # JSON
kubectl get <resource> -o name                  # Apenas nomes
kubectl get <resource> --show-labels            # Mostra labels
kubectl get <resource> -l key=value             # Filtra por label
kubectl get <resource> --field-selector k=v     # Filtra por campo
kubectl get <resource> -w                       # Observa alterações (watch)
kubectl get <resource> --sort-by=.metadata.name # Ordena
kubectl describe <resource> <name>              # Detalhes + eventos
kubectl get all                                 # Recursos comuns do namespace
kubectl get all -A                              # Recursos comuns de todos os namespaces
```

> `get all` não lista tudo: omite ConfigMaps, Secrets, Ingress, PVC etc.

### Eventos

```bash
kubectl events                           # Eventos do namespace
kubectl events -n <ns>                   # Eventos de outro namespace
kubectl events --types=Warning           # Apenas warnings
kubectl get events --sort-by=.lastTimestamp # Eventos ordenados (alternativa)
```

## 5. Criar, aplicar e editar

```bash
kubectl apply -f manifest.yaml              # Cria/atualiza (declarativo)
kubectl apply -f ./directory/               # Aplica um diretório
kubectl apply -R -f ./directory/            # Aplica recursivamente
kubectl apply -k ./directory/               # Aplica Kustomize
kubectl apply --dry-run=client -f file.yaml # Simula localmente
kubectl apply --dry-run=server -f file.yaml # Valida no servidor
kubectl diff -f manifest.yaml               # Mostra o que mudaria
kubectl create -f manifest.yaml             # Cria (falha se já existir)
kubectl create -f -                         # Cria lendo stdin
kubectl edit <resource> <name>              # Edita no editor
kubectl patch <resource> <name> -p '...'    # Atualização parcial
kubectl replace -f manifest.yaml            # Substitui o recurso
kubectl replace --force -f manifest.yaml    # Remove e recria
kubectl delete -f manifest.yaml             # Remove o que está no manifesto
kubectl wait --for=condition=Ready pod/<pod> --timeout=60s # Aguarda condição
```

## 6. Namespaces

```bash
kubectl get namespaces                   # Lista namespaces
kubectl create namespace <ns>            # Cria namespace
kubectl describe namespace <ns>          # Detalha namespace
kubectl delete namespace <ns>            # Remove (apaga tudo dentro dele!)
kubectl config set-context --current --namespace=<ns> # Define namespace padrão
```

## 7. Pods

```bash
kubectl get pods                          # Lista Pods
kubectl get pods -A -o wide               # Todos os namespaces, com Node e IP
kubectl describe pod <pod>                # Inspeciona Pod
kubectl logs <pod>                        # Logs
kubectl logs <pod> -f                     # Logs em tempo real
kubectl logs <pod> --tail=100             # Últimas 100 linhas
kubectl logs <pod> --previous             # Logs da execução anterior (após crash)
kubectl logs <pod> -c <container>         # Logs de um container
kubectl logs -l app=<name>                # Logs por label
kubectl exec -it <pod> -- sh              # Shell no Pod
kubectl exec -it <pod> -c <container> -- sh # Shell em um container específico
kubectl exec <pod> -- env                 # Executa um comando
kubectl attach -it <pod>                  # Anexa ao processo principal
kubectl port-forward pod/<pod> 8080:80    # Encaminha porta (local:pod)
kubectl cp <pod>:/path ./local            # Copia do Pod
kubectl cp ./local <pod>:/path            # Copia para o Pod
kubectl delete pod <pod>                  # Remove Pod
kubectl delete pods -l app=<name>         # Remove por label
```

### Pod temporário

```bash
kubectl run <name> -it --rm --image=<image> -- /bin/bash   # Pod descartável (--rm remove ao sair)
kubectl run nginx --image=nginx                            # Pod simples
kubectl run nginx --image=nginx --port=80 --labels="app=nginx" # Com porta e label
```

## 8. Deployments e Rollout

```bash
kubectl get deployments                   # Lista Deployments
kubectl describe deployment <name>        # Detalha Deployment
kubectl create deployment <name> --image=<image> --replicas=3 # Cria Deployment
kubectl set image deployment/<name> <container>=<image>       # Atualiza imagem (rolling update)
kubectl scale deployment/<name> --replicas=3                  # Escala
kubectl delete deployment <name>          # Remove Deployment
```

### Rollout (vale para Deployment, StatefulSet e DaemonSet)

```bash
kubectl rollout status <resource>/<name>                  # Acompanha o rollout
kubectl rollout history <resource>/<name>                 # Histórico de revisões
kubectl rollout history <resource>/<name> --revision=<n>  # Detalhes de uma revisão
kubectl rollout undo <resource>/<name>                    # Rollback
kubectl rollout undo <resource>/<name> --to-revision=<n>  # Rollback para revisão específica
kubectl rollout pause <resource>/<name>                   # Pausa
kubectl rollout resume <resource>/<name>                  # Continua
kubectl rollout restart <resource>/<name>                 # Reinicia os Pods
```

> O histórico só registra a causa da mudança com `kubectl annotate deployment/<name> kubernetes.io/change-cause="motivo"`.

## 9. ReplicaSets, StatefulSets e DaemonSets

```bash
# ReplicaSet
kubectl get replicasets                       # Lista
kubectl describe rs <name>                    # Detalha
kubectl scale rs/<name> --replicas=3          # Escala
kubectl delete rs <name>                      # Remove

# StatefulSet
kubectl get statefulsets                      # Lista
kubectl describe statefulset <name>           # Detalha
kubectl scale statefulset <name> --replicas=3 # Escala
kubectl delete statefulset <name>             # Remove

# DaemonSet
kubectl get daemonsets                        # Lista
kubectl describe daemonset <name>             # Detalha
kubectl delete daemonset <name>               # Remove
```

## 10. Jobs e CronJobs

```bash
kubectl get jobs                          # Lista Jobs
kubectl create job <name> --image=<image> # Cria Job
kubectl create job <name> --from=cronjob/<cronjob> # Executa um CronJob manualmente
kubectl describe job <name>               # Detalha Job
kubectl delete job <name>                 # Remove Job

kubectl get cronjobs                      # Lista CronJobs
kubectl create cronjob <name> --image=<image> --schedule="*/5 * * * *" # Cria CronJob
kubectl describe cronjob <name>           # Detalha
kubectl patch cronjob <name> -p '{"spec":{"suspend":true}}' # Suspende
kubectl delete cronjob <name>             # Remove
```

## 11. Services, Endpoints e Ingress

```bash
kubectl get services                       # Lista Services
kubectl describe service <name>            # Detalha
kubectl expose deployment <name> --port=80 --target-port=8080 # Cria Service para o Deployment
kubectl expose deployment <name> --type=NodePort --port=80    # Service NodePort
kubectl port-forward service/<name> 8080:80 # Encaminha porta
kubectl delete service <name>              # Remove

kubectl get endpoints                      # Lista Endpoints (deprecado)
kubectl get endpointslices                 # Lista EndpointSlices
kubectl describe endpointslice <name>      # Detalha

kubectl get ingress                        # Lista Ingresses
kubectl describe ingress <name>            # Detalha
kubectl delete ingress <name>              # Remove
```

### Tipos de Service

```text
ClusterIP     # Acesso interno (padrão)
NodePort      # Porta em todos os Nodes
LoadBalancer  # Balanceador externo
ExternalName  # Alias DNS externo
```

## 12. ConfigMaps e Secrets

```bash
# ConfigMap
kubectl get configmaps                     # Lista
kubectl create configmap <name> --from-literal=KEY=value
kubectl create configmap <name> --from-file=config.properties
kubectl create configmap <name> --from-env-file=.env
kubectl describe configmap <name>          # Detalha
kubectl edit configmap <name>              # Edita
kubectl delete configmap <name>            # Remove

# Secret
kubectl get secrets                        # Lista
kubectl describe secret <name>             # Metadados (não mostra valores)
kubectl create secret generic <name> --from-literal=KEY=value
kubectl create secret generic <name> --from-file=./file
kubectl create secret docker-registry <name> --docker-server=<srv> --docker-username=<user> --docker-password=<pass>
kubectl create secret tls <name> --cert=tls.crt --key=tls.key
kubectl edit secret <name>                 # Edita
kubectl delete secret <name>               # Remove
```

> `kubectl get secret <name> -o yaml` exibe os dados em Base64; Base64 **não** é criptografia.

## 13. Volumes e Storage

```bash
kubectl get persistentvolumes                 # Lista PVs
kubectl get persistentvolumeclaims            # Lista PVCs
kubectl get storageclasses                    # Lista StorageClasses
kubectl describe pv <name>                  # Detalha PV
kubectl describe pvc <name>                 # Detalha PVC
kubectl describe storageclass <name>        # Detalha StorageClass
kubectl patch pvc <name> -p '{"spec":{"resources":{"requests":{"storage":"10Gi"}}}}' # Expande PVC
kubectl delete pvc <name>                   # Remove PVC
kubectl delete pv <name>                    # Remove PV
```

## 14. Nodes

```bash
kubectl get nodes -o wide                   # Lista Nodes
kubectl describe node <node>                # Detalha Node
kubectl top nodes                           # CPU/memória (requer metrics-server)
kubectl cordon <node>                       # Impede novos Pods
kubectl uncordon <node>                     # Libera o Node
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data # Evacua os Pods
kubectl taint nodes <node> key=value:NoSchedule # Adiciona taint
kubectl taint nodes <node> key:NoSchedule-  # Remove taint
kubectl label node <node> key=value         # Adiciona label
kubectl label node <node> key-              # Remove label
```

## 15. Labels e Annotations

```bash
kubectl label <resource> <name> key=value            # Adiciona label
kubectl label <resource> <name> key=novo --overwrite # Altera label existente
kubectl label <resource> <name> key-                 # Remove label
kubectl annotate <resource> <name> key=value         # Adiciona annotation
kubectl annotate <resource> <name> key-              # Remove annotation
```

## 16. Autoscaling, recursos e métricas

```bash
kubectl get hpa                              # Lista HPAs
kubectl describe hpa <name>                  # Detalha
kubectl autoscale deployment/<name> --min=2 --max=10 --cpu-percent=70 # Cria HPA
kubectl delete hpa <name>                    # Remove

kubectl top pods                             # CPU/memória dos Pods (requer metrics-server)
kubectl top pods -A                          # Todos os namespaces
kubectl top pod <pod> --containers           # Por container
kubectl get resourcequota                    # Quotas
kubectl describe resourcequota <name>        # Detalha quota
kubectl get limitrange                       # Limites padrão
kubectl describe limitrange <name>           # Detalha
```

## 17. RBAC

```bash
kubectl get serviceaccounts                  # Lista ServiceAccounts
kubectl create serviceaccount <name>         # Cria
kubectl describe serviceaccount <name>       # Detalha

kubectl get roles                            # Lista Roles
kubectl get rolebindings                     # Lista RoleBindings
kubectl get clusterroles                     # Lista ClusterRoles
kubectl get clusterrolebindings              # Lista ClusterRoleBindings

kubectl create role <name> --verb=get,list --resource=pods
kubectl create rolebinding <name> --role=<role> --user=<user>
kubectl create rolebinding <name> --role=<role> --serviceaccount=<ns>:<sa>
kubectl create clusterrole <name> --verb=get,list --resource=pods
kubectl create clusterrolebinding <name> --clusterrole=<role> --user=<user>

kubectl auth can-i get pods                  # Verifica permissão
kubectl auth can-i create deployments
kubectl auth can-i get pods --as=<user>      # Verifica como outro usuário
kubectl auth can-i --list                    # Lista permissões
```

## 18. NetworkPolicy

```bash
kubectl get networkpolicies                  # Lista
kubectl describe networkpolicy <name>        # Detalha
kubectl delete networkpolicy <name>          # Remove
```

## 19. Troubleshooting e Debug

```bash
kubectl get pods -A -o wide                           # Visão geral dos Pods
kubectl get pods --sort-by=.status.startTime          # Ordena por início
kubectl get events -A --sort-by=.lastTimestamp        # Eventos recentes
kubectl describe pod <pod> -n <ns>                    # Diagnóstico (veja a seção Events)
kubectl logs <pod> -n <ns> --previous                 # Logs do container que caiu
kubectl describe node <node>                          # Problemas do Node
kubectl top pods -A                                   # Consumo dos Pods
kubectl top nodes                                     # Consumo dos Nodes
kubectl get endpointslices -n <ns>                    # Service sem destino? Confira os endpoints
kubectl auth can-i --list                             # Permissões do usuário atual

kubectl run debug --rm -it --image=busybox -- sh              # Pod temporário
kubectl run curl --rm -it --image=curlimages/curl -- sh       # Teste HTTP dentro do cluster
kubectl debug pod/<pod> -it --image=busybox                   # Container efêmero no Pod
kubectl debug pod/<pod> --copy-to=<new-pod> -it --image=busybox # Cópia do Pod para debug
kubectl debug node/<node> -it --image=ubuntu                  # Debug de Node
```

### Estados comuns de Pod

| Status               | Causa provável                                         |
| -------------------- | ------------------------------------------------------ |
| `Pending`            | Sem Node disponível (recursos, taint) ou PVC não ligado |
| `ImagePullBackOff`   | Imagem/tag inexistente ou sem credencial do registry   |
| `CrashLoopBackOff`   | Container falha ao iniciar → veja `logs --previous`    |
| `OOMKilled`          | Estourou o limite de memória                           |
| `Service` sem acesso | Selector do Service não bate com as labels dos Pods    |

## 20. Gerar manifestos (dry-run)

```bash
kubectl create deployment app --image=nginx --dry-run=client -o yaml
kubectl expose deployment app --port=80 --dry-run=client -o yaml
kubectl create configmap app --from-literal=KEY=value --dry-run=client -o yaml
kubectl create secret generic app --from-literal=KEY=value --dry-run=client -o yaml
kubectl create service clusterip app --tcp=80:8080 --dry-run=client -o yaml
kubectl run app --image=nginx --dry-run=client -o yaml > pod.yaml
```

## 21. JSONPath e seletores

```bash
kubectl get pods -o jsonpath='{.items[*].metadata.name}'
kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.kubeletVersion}'
kubectl get secret <name> -o jsonpath='{.data.KEY}' | base64 -d
kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase

kubectl get pods -l app=api
kubectl get pods -l 'app in (api,web)'
kubectl get pods -l 'app notin (api,web)'
kubectl get pods --field-selector=status.phase=Running
kubectl get pods --field-selector=spec.nodeName=<node>
```

## 22. Administração, plugins e proxy

```bash
kubectl get csr                            # Lista CSRs
kubectl certificate approve <csr>          # Aprova CSR
kubectl certificate deny <csr>             # Nega CSR
kubectl delete csr <name>                  # Remove CSR

kubectl plugin list                        # Lista plugins
kubectl proxy                              # Proxy para o API Server
kubectl proxy --port=8080                  # Define a porta
```

## 23. Produtividade (completion e alias)

```bash
source <(kubectl completion bash)          # Autocomplete Bash (também: zsh, fish, powershell)
```

```bash
alias k=kubectl
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kga='kubectl get all'
alias kaf='kubectl apply -f'
complete -o default -F __start_kubectl k   # Autocomplete também para o alias k
```

## 24. Abreviações de recursos

| Abreviação | Recurso                 |
| ---------- | ----------------------- |
| `po`       | Pod                     |
| `deploy`   | Deployment              |
| `rs`       | ReplicaSet              |
| `sts`      | StatefulSet             |
| `ds`       | DaemonSet               |
| `svc`      | Service                 |
| `ing`      | Ingress                 |
| `cm`       | ConfigMap               |
| `secret`   | Secret                  |
| `ns`       | Namespace               |
| `pv`       | PersistentVolume        |
| `pvc`      | PersistentVolumeClaim   |
| `sc`       | StorageClass            |
| `job`      | Job                     |
| `cj`       | CronJob                 |
| `sa`       | ServiceAccount          |
| `hpa`      | HorizontalPodAutoscaler |
| `no`       | Node                    |
| `ep`       | Endpoints               |
| `netpol`   | NetworkPolicy           |

## 25. Fluxo básico

```bash
kubectl config current-context           # 1. Em qual cluster estou?
kubectl get nodes                        # 2. O cluster está saudável?
kubectl get namespaces
kubectl apply -f app.yaml                # 3. Aplica o manifesto
kubectl get pods                         # 4. Acompanha
kubectl describe pod <pod>               # 5. Algo errado? Diagnostica
kubectl logs <pod>
kubectl exec -it <pod> -- sh
kubectl rollout status deployment/<name> # 6. Acompanha o rollout
kubectl rollout undo deployment/<name>   # 7. Deu errado? Rollback
```
