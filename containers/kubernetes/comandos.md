# Kubernetes — Cheat Sheet de Comandos

> Referência rápida de `kubectl`. Sintaxe mínima + finalidade.

## 1. Contexto e configuração

```bash
kubectl version                         # Versões cliente/servidor
kubectl cluster-info                    # Informações do cluster
kubectl config view                     # Exibe configuração
kubectl config get-contexts             # Lista contexts
kubectl config current-context          # Context atual
kubectl config use-context <ctx>        # Troca context
kubectl config set-context <ctx> ...    # Altera context
kubectl config delete-context <ctx>     # Remove context
kubectl config get-clusters              # Lista clusters
kubectl config set-cluster <name> ...   # Configura cluster
kubectl config set-credentials <name>   # Configura credencial
kubectl config rename-context <a> <b>   # Renomeia context
kubectl config unset <property>         # Remove propriedade
```

## 2. Descoberta e documentação

```bash
kubectl api-resources                    # Lista recursos da API
kubectl api-versions                     # Lista versões da API
kubectl explain <resource>               # Documentação do recurso
kubectl explain <resource>.<field>       # Documentação de campo
kubectl options                          # Opções globais
kubectl help                              # Ajuda
kubectl <command> --help                 # Ajuda do comando
```

## 3. Inspeção de recursos

```bash
kubectl get <resource>                   # Lista recursos
kubectl get <resource> -A                # Todos os namespaces
kubectl get <resource> -n <ns>           # Namespace específico
kubectl get <resource> -o yaml           # YAML
kubectl get <resource> -o json           # JSON
kubectl get <resource> -o wide           # Mais detalhes
kubectl get <resource> -o name           # Apenas nomes
kubectl get <resource> --show-labels     # Mostra labels
kubectl get <resource> -l key=value      # Filtra por label
kubectl get <resource> --field-selector key=value # Filtra campos
kubectl get <resource> -w                # Observa alterações
kubectl get <resource> --sort-by=.metadata.name # Ordena
kubectl describe <resource> <name>       # Detalhes + eventos
kubectl events                            # Eventos do cluster
kubectl events -n <ns>                   # Eventos do namespace
kubectl events --types=Warning           # Eventos de warning
```

## 4. Namespaces

```bash
kubectl get namespaces                   # Lista namespaces
kubectl create namespace <ns>            # Cria namespace
kubectl describe namespace <ns>           # Detalha namespace
kubectl delete namespace <ns>            # Remove namespace
kubectl config set-context --current --namespace=<ns> # Define namespace padrão
```

## 5. Pods

```bash
kubectl get pods                          # Lista Pods
kubectl get pods -A                       # Todos os namespaces
kubectl describe pod <pod>                # Inspeciona Pod
kubectl logs <pod>                        # Logs
kubectl logs <pod> -f                     # Logs em tempo real
kubectl logs <pod> --previous             # Logs da execução anterior
kubectl logs <pod> -c <container>         # Logs de container
kubectl logs -l app=<name>                # Logs por label
kubectl exec -it <pod> -- <cmd>           # Executa comando
kubectl exec -it <pod> -c <container> -- sh # Shell no container
kubectl attach -it <pod>                  # Anexa ao processo
kubectl port-forward pod/<pod> 8080:80    # Encaminha porta
kubectl cp <pod>:/path ./local            # Copia do Pod
kubectl cp ./local <pod>:/path            # Copia para o Pod
kubectl delete pod <pod>                  # Remove Pod
kubectl delete pods -l app=<name>         # Remove por label
kubectl wait --for=condition=Ready pod/<pod> # Aguarda condição
```

## 6. Deployments

```bash
kubectl get deployments                   # Lista Deployments
kubectl describe deployment <name>        # Detalha Deployment
kubectl create deployment <name> --image=<image> # Cria Deployment
kubectl set image deployment/<name> <container>=<image> # Atualiza imagem
kubectl rollout status deployment/<name>  # Acompanha rollout
kubectl rollout history deployment/<name> # Histórico
kubectl rollout history deployment/<name> --revision=<n> # Revisão
kubectl rollout undo deployment/<name>    # Rollback
kubectl rollout undo deployment/<name> --to-revision=<n> # Rollback específico
kubectl rollout pause deployment/<name>   # Pausa rollout
kubectl rollout resume deployment/<name>  # Continua rollout
kubectl rollout restart deployment/<name> # Reinicia Pods
kubectl scale deployment/<name> --replicas=3 # Escala
kubectl autoscale deployment/<name> --min=2 --max=10 --cpu-percent=70 # HPA
kubectl delete deployment <name>          # Remove Deployment
```

## 7. ReplicaSets

```bash
kubectl get replicasets                  # Lista ReplicaSets
kubectl describe rs <name>               # Detalha ReplicaSet
kubectl scale rs/<name> --replicas=3     # Escala
kubectl delete rs <name>                 # Remove ReplicaSet
```

## 8. StatefulSets

```bash
kubectl get statefulsets                  # Lista StatefulSets
kubectl describe statefulset <name>       # Detalha
kubectl scale statefulset <name> --replicas=3 # Escala
kubectl rollout status statefulset/<name> # Rollout
kubectl rollout restart statefulset/<name> # Reinicia
kubectl delete statefulset <name>         # Remove
```

## 9. DaemonSets

```bash
kubectl get daemonsets                    # Lista DaemonSets
kubectl describe daemonset <name>         # Detalha
kubectl rollout status daemonset/<name>   # Rollout
kubectl rollout restart daemonset/<name>  # Reinicia
kubectl delete daemonset <name>           # Remove
```

## 10. Jobs e CronJobs

```bash
kubectl get jobs                          # Lista Jobs
kubectl create job <name> --image=<image> # Cria Job
kubectl describe job <name>               # Detalha Job
kubectl delete job <name>                 # Remove Job

kubectl get cronjobs                      # Lista CronJobs
kubectl create cronjob <name> --image=<image> --schedule="*/5 * * * *" # Cria
kubectl describe cronjob <name>           # Detalha
kubectl suspend cronjob <name>            # Suspende
kubectl delete cronjob <name>             # Remove
```

## 11. Services

```bash
kubectl get services                       # Lista Services
kubectl describe service <name>            # Detalha
kubectl expose deployment <name> --port=80 --target-port=8080 # Expõe
kubectl port-forward service/<name> 8080:80 # Encaminha porta
kubectl delete service <name>              # Remove
```

### Tipos de Service

```text
ClusterIP     # Acesso interno
NodePort      # Porta no Node
LoadBalancer  # Balanceador externo
ExternalName  # Alias DNS externo
```

## 12. Ingress

```bash
kubectl get ingress                        # Lista Ingresses
kubectl describe ingress <name>            # Detalha
kubectl delete ingress <name>              # Remove
```

## 13. ConfigMaps

```bash
kubectl get configmaps                     # Lista
kubectl create configmap <name> --from-literal=KEY=value
kubectl create configmap <name> --from-file=config.properties
kubectl describe configmap <name>          # Detalha
kubectl edit configmap <name>              # Edita
kubectl delete configmap <name>            # Remove
```

## 14. Secrets

```bash
kubectl get secrets                        # Lista
kubectl describe secret <name>             # Metadados
kubectl create secret generic <name> --from-literal=KEY=value
kubectl create secret generic <name> --from-file=./file
kubectl create secret docker-registry <name> ... # Secret de registry
kubectl edit secret <name>                 # Edita
kubectl delete secret <name>               # Remove
```

> `kubectl get secret <name> -o yaml` exibe dados codificados em Base64; Base64 não é criptografia.

## 15. Volumes e Storage

```bash
kubectl get persistentvolumes               # Lista PVs
kubectl get persistentvolumeclaims          # Lista PVCs
kubectl describe pv <name>                  # Detalha PV
kubectl describe pvc <name>                 # Detalha PVC
kubectl delete pvc <name>                   # Remove PVC
kubectl delete pv <name>                    # Remove PV
kubectl get storageclasses                  # Lista StorageClasses
kubectl describe storageclass <name>        # Detalha
kubectl patch pvc <name> ...                # Altera PVC
```

## 16. Nodes

```bash
kubectl get nodes                           # Lista Nodes
kubectl get nodes -o wide                   # Mais detalhes
kubectl describe node <node>                # Detalha Node
kubectl top nodes                           # CPU/memória
kubectl cordon <node>                       # Impede novos Pods
kubectl uncordon <node>                     # Libera Node
kubectl drain <node>                        # Evacua Pods
kubectl taint nodes <node> key=value:NoSchedule # Adiciona taint
kubectl taint nodes <node> key:NoSchedule-  # Remove taint
kubectl label node <node> key=value         # Adiciona label
kubectl label node <node> key-              # Remove label
```

## 17. Labels e Annotations

```bash
kubectl label <resource> <name> key=value   # Adiciona label
kubectl label <resource> <name> key-        # Remove label
kubectl annotate <resource> <name> key=value # Adiciona annotation
kubectl annotate <resource> <name> key-     # Remove annotation
```

## 18. Apply / Create / Edit / Patch

```bash
kubectl apply -f manifest.yaml              # Cria/atualiza declarativamente
kubectl apply -f ./directory/               # Aplica diretório
kubectl apply -k ./directory/               # Aplica Kustomize
kubectl apply --dry-run=client -f file.yaml # Simula localmente
kubectl apply --dry-run=server -f file.yaml # Valida no servidor
kubectl create -f manifest.yaml             # Cria a partir do manifesto
kubectl create -f -                         # Cria lendo stdin
kubectl edit <resource> <name>              # Edita no editor
kubectl patch <resource> <name> -p '...'    # Atualização parcial
kubectl replace -f manifest.yaml            # Substitui recurso
kubectl replace --force -f manifest.yaml    # Remove e recria
kubectl delete -f manifest.yaml             # Remove manifesto
```

## 19. Rollout e atualização

```bash
kubectl rollout status <resource>/<name>    # Status
kubectl rollout history <resource>/<name>   # Histórico
kubectl rollout undo <resource>/<name>      # Rollback
kubectl rollout restart <resource>/<name>  # Reinicia
kubectl rollout pause <resource>/<name>     # Pausa
kubectl rollout resume <resource>/<name>    # Continua
```

## 20. HPA / Autoscaling

```bash
kubectl get hpa                              # Lista HPA
kubectl describe hpa <name>                  # Detalha
kubectl autoscale deployment/<name> --min=2 --max=10 --cpu-percent=70
kubectl delete hpa <name>                   # Remove
```

## 21. Recursos e métricas

```bash
kubectl top pods                             # CPU/memória dos Pods
kubectl top pods -A                          # Todos namespaces
kubectl top pod <pod> --containers           # Por container
kubectl top nodes                            # CPU/memória dos Nodes
kubectl get resourcequota                    # Quotas
kubectl describe resourcequota <name>        # Detalha quota
kubectl get limitrange                       # Limites padrão
kubectl describe limitrange <name>           # Detalha
```

## 22. RBAC

```bash
kubectl get serviceaccounts                  # Lista ServiceAccounts
kubectl create serviceaccount <name>         # Cria
kubectl describe serviceaccount <name>       # Detalha

kubectl get roles                             # Lista Roles
kubectl get rolebindings                      # Lista RoleBindings
kubectl get clusterroles                      # Lista ClusterRoles
kubectl get clusterrolebindings               # Lista ClusterRoleBindings

kubectl create role <name> --verb=get,list --resource=pods
kubectl create rolebinding <name> --role=<role> --user=<user>
kubectl create rolebinding <name> --role=<role> --serviceaccount=<ns>:<sa>
kubectl create clusterrole <name> --verb=get,list --resource=pods
kubectl create clusterrolebinding <name> --clusterrole=<role> --user=<user>

kubectl auth can-i get pods                    # Verifica permissão
kubectl auth can-i create deployments
kubectl auth can-i --list                     # Lista permissões
```

## 23. NetworkPolicy

```bash
kubectl get networkpolicies                   # Lista
kubectl describe networkpolicy <name>         # Detalha
kubectl delete networkpolicy <name>           # Remove
```

## 24. Endpoints / EndpointSlices

```bash
kubectl get endpoints                         # Lista Endpoints
kubectl describe endpoints <name>             # Detalha
kubectl get endpointslices                    # Lista EndpointSlices
kubectl describe endpointslice <name>         # Detalha
```

## 25. Discovery / DNS / Troubleshooting

```bash
kubectl get all                               # Recursos comuns
kubectl get all -A                            # Recursos comuns em todos namespaces
kubectl get pods --sort-by=.status.startTime  # Ordena Pods
kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase
kubectl get pods -o jsonpath='{.items[*].metadata.name}' # JSONPath
kubectl describe pod <pod>                    # Diagnóstico detalhado
kubectl logs <pod>                            # Diagnóstico via logs
kubectl logs <pod> --previous                 # Container anterior
kubectl exec -it <pod> -- sh                  # Acessa container
kubectl run debug --rm -it --image=busybox -- sh # Pod temporário
kubectl run curl --rm -it --image=curlimages/curl -- sh # Teste HTTP
kubectl port-forward pod/<pod> 8080:80        # Teste local
kubectl get events --sort-by=.lastTimestamp   # Eventos ordenados
kubectl describe node <node>                  # Problemas do Node
```

## 26. Debug

```bash
kubectl debug pod/<pod> -it --image=busybox   # Debug de Pod
kubectl debug node/<node> -it --image=ubuntu  # Debug de Node
kubectl debug pod/<pod> --copy-to=<new-pod>   # Cria cópia para debug
```

## 27. Deployment Strategies

```bash
kubectl set image deployment/<name> <container>=<image> # Rolling Update
kubectl rollout status deployment/<name>                # Acompanha
kubectl rollout undo deployment/<name>                  # Rollback
kubectl scale deployment/<name> --replicas=0            # Escala para zero
```

## 28. YAML / Manifestos

```bash
kubectl create deployment app --image=nginx --dry-run=client -o yaml
kubectl expose deployment app --port=80 --dry-run=client -o yaml
kubectl create configmap app --from-literal=KEY=value --dry-run=client -o yaml
kubectl create secret generic app --from-literal=KEY=value --dry-run=client -o yaml
kubectl create service clusterip app --tcp=80:8080 --dry-run=client -o yaml
```

## 29. JSONPath

```bash
kubectl get pods -o jsonpath='{.items[*].metadata.name}'
kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.kubeletVersion}'
kubectl get secret <name> -o jsonpath='{.data.KEY}' | base64 -d
```

## 30. Seletores

```bash
kubectl get pods -l app=api
kubectl get pods -l 'app in (api,web)'
kubectl get pods -l 'app notin (api,web)'
kubectl get pods --field-selector=status.phase=Running
kubectl get pods --field-selector=spec.nodeName=<node>
```

## 31. Namespaces + recursos

```bash
kubectl get pods -n <ns>
kubectl get svc -n <ns>
kubectl get deploy -n <ns>
kubectl get secrets -n <ns>
kubectl get configmaps -n <ns>
kubectl get events -n <ns>
kubectl delete pod <pod> -n <ns>
```

## 32. Comandos genéricos

```bash
kubectl get <resource>                    # Consulta
kubectl describe <resource> <name>        # Detalha
kubectl create <resource> ...             # Cria
kubectl delete <resource> <name>          # Remove
kubectl edit <resource> <name>            # Edita
kubectl patch <resource> <name> ...       # Altera parcialmente
kubectl label <resource> <name> ...       # Labels
kubectl annotate <resource> <name> ...    # Annotations
kubectl wait ...                           # Aguarda condição
```

## 33. Comandos administrativos

```bash
kubectl certificate approve <csr>          # Aprova CSR
kubectl certificate deny <csr>             # Nega CSR
kubectl certificate list                   # Lista CSRs
kubectl get csr                            # Lista CSRs
kubectl delete csr <name>                  # Remove CSR
```

## 34. Plugins

```bash
kubectl plugin list                        # Lista plugins
kubectl plugin <plugin>                    # Executa plugin
```

## 35. Proxy

```bash
kubectl proxy                              # Proxy para API Server
kubectl proxy --port=8080                  # Define porta
```

## 36. Attach / Copy / Exec

```bash
kubectl attach <pod> -it                   # Conecta ao processo
kubectl cp <pod>:/tmp/file ./file          # Pod → máquina
kubectl cp ./file <pod>:/tmp/file          # Máquina → Pod
kubectl exec <pod> -- env                  # Executa comando
kubectl exec <pod> -- cat /etc/hosts       # Lê arquivo
```

## 37. Completion

```bash
kubectl completion bash                    # Autocomplete Bash
kubectl completion zsh                     # Autocomplete Zsh
kubectl completion fish                    # Autocomplete Fish
kubectl completion powershell              # Autocomplete PowerShell
```

## 38. Alias úteis

```bash
alias k=kubectl
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kga='kubectl get all'
alias kaf='kubectl apply -f'
```

## 39. Atalhos de troubleshooting

```bash
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp
kubectl describe pod <pod> -n <ns>
kubectl logs <pod> -n <ns> --previous
kubectl describe node <node>
kubectl top pods -A
kubectl top nodes
kubectl get endpoints <service> -n <ns>
kubectl get endpointslices -n <ns>
kubectl auth can-i --list
```

## 40. Fluxo básico

```bash
kubectl config current-context
kubectl get nodes
kubectl get namespaces
kubectl get pods -A
kubectl apply -f app.yaml
kubectl get pods
kubectl describe pod <pod>
kubectl logs <pod>
kubectl exec -it <pod> -- sh
kubectl rollout status deployment/<name>
kubectl rollout undo deployment/<name>
```

## 41. Recursos mais usados

| Abreviação | Recurso |
|---|---|
| `po` | Pod |
| `deploy` | Deployment |
| `rs` | ReplicaSet |
| `sts` | StatefulSet |
| `ds` | DaemonSet |
| `svc` | Service |
| `ing` | Ingress |
| `cm` | ConfigMap |
| `secret` | Secret |
| `ns` | Namespace |
| `pv` | PersistentVolume |
| `pvc` | PersistentVolumeClaim |
| `sc` | StorageClass |
| `job` | Job |
| `cj` | CronJob |
| `sa` | ServiceAccount |
| `hpa` | HorizontalPodAutoscaler |
| `no` | Node |
| `rs` | ReplicaSet |
| `ep` | Endpoints |

## 42. Sintaxe geral

```text
kubectl [comando] [tipo] [nome] [flags]
```

Exemplo:

```bash
kubectl get pods api-7d8f9c -n production -o yaml
```

`kubectl` = CLI  
`get` = ação  
`pods` = recurso  
`api-7d8f9c` = objeto  
`-n` = namespace  
`-o yaml` = formato da saída


> criar um macked pod 

```bash
kubectl run <name> -it --image <image> -- /bin/bash
```