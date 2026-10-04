Abaixo está um material em formato **Markdown pronto para copiar e colar**, com uma abordagem de especialista, mas explicada de forma simples. Mantive o conteúdo enxuto, porém cobrindo os conceitos fundamentais e a relação entre eles.

# Kubernetes — Objetos e Comunicação

## 1. API Version

Todo objeto Kubernetes possui um campo `apiVersion`.

```yaml
apiVersion: apps/v1
```

Ele informa **qual versão da API do Kubernetes deve ser utilizada para interpretar o objeto**.

Exemplo:

```yaml
apiVersion: v1
kind: Pod
```

```yaml
apiVersion: apps/v1
kind: Deployment
```

### Principais versões

| API Version                    | Uso                                            |
| ------------------------------ | ---------------------------------------------- |
| `v1`                           | Pod, Service, ConfigMap, Secret, Namespace     |
| `apps/v1`                      | Deployment, ReplicaSet, StatefulSet, DaemonSet |
| `batch/v1`                     | Job, CronJob                                   |
| `networking.k8s.io/v1`         | Ingress, NetworkPolicy                         |
| `autoscaling/v2`               | HorizontalPodAutoscaler                        |
| `rbac.authorization.k8s.io/v1` | Role, RoleBinding, ClusterRole                 |

> A `apiVersion` define o contrato da API usado para criar e manipular o objeto.

---

# 2. Objetos

No Kubernetes, quase tudo é representado como um **objeto**.

Um objeto descreve o **estado desejado** de alguma parte do cluster.

Exemplo:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx

spec:
  containers:
    - name: nginx
      image: nginx
```

Os principais campos são:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx

spec:
  ...
```

### Estrutura

```text
apiVersion
    ↓
Define a API

kind
    ↓
Define o tipo do objeto

metadata
    ↓
Identificação do objeto

spec
    ↓
Estado desejado
```

### Exemplos de objetos

```text
Pod
ReplicaSet
Deployment
Service
ConfigMap
Secret
Namespace
Ingress
PersistentVolume
PersistentVolumeClaim
Job
CronJob
StatefulSet
DaemonSet
```

---

# 3. Interação com Objetos

O Kubernetes utiliza a API Server para receber operações sobre os objetos.

Normalmente interagimos através do `kubectl`.

```bash
kubectl get pods
kubectl describe pod nginx
kubectl create -f pod.yaml
kubectl apply -f pod.yaml
kubectl delete pod nginx
```

### Fluxo

```text
kubectl
   ↓
API Server
   ↓
Objeto Kubernetes
   ↓
Controladores
   ↓
Estado desejado
```

### Principais operações

```bash
kubectl get        # Consulta
kubectl describe   # Detalha
kubectl create     # Cria
kubectl apply      # Cria ou atualiza
kubectl edit       # Edita
kubectl patch      # Altera parcialmente
kubectl delete     # Remove
```

### Declarativo x Imperativo

**Imperativo:**

```bash
kubectl create deployment nginx --image=nginx
```

Você informa **o que fazer**.

**Declarativo:**

```bash
kubectl apply -f deployment.yaml
```

Você informa **como o estado desejado deve ser**.

O Kubernetes trabalha fortemente com o modelo declarativo:

```text
Estado desejado
      ↓
     YAML
      ↓
  API Server
      ↓
 Controladores
      ↓
Estado atual
```

Os controladores trabalham continuamente para aproximar o **estado atual** do **estado desejado**.

---

# 4. Pod

O **Pod** é a menor unidade executável do Kubernetes.

Ele representa um ou mais containers que compartilham:

* Rede
* IP
* Volumes
* Namespace

Exemplo:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx

spec:
  containers:
    - name: nginx
      image: nginx
```

### Estrutura

```text
Pod
 ├── Container
 ├── Container
 ├── Network
 └── Volumes
```

Normalmente:

```text
1 Pod
   ↓
1 aplicação/container
```

Mas um Pod pode possuir múltiplos containers:

```text
Pod
 ├── App
 └── Sidecar
```

### Importante

Pods são **efêmeros**.

Se um Pod morrer, normalmente outro Pod deve ser criado.

Por isso, aplicações reais normalmente não são gerenciadas diretamente por Pods.

Usamos:

```text
Deployment
    ↓
ReplicaSet
    ↓
Pods
```

---

# 5. ReplicaSet

O **ReplicaSet** garante que uma quantidade determinada de Pods esteja executando.

Exemplo:

```yaml
apiVersion: apps/v1
kind: ReplicaSet

metadata:
  name: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx
          image: nginx
```

O objetivo é:

```text
Desejado:

3 Pods

Atual:

2 Pods

ReplicaSet:

→ cria 1 Pod
```

Se um Pod morrer:

```text
3 Pods
 ↓
1 Pod morreu
 ↓
2 Pods
 ↓
ReplicaSet percebe
 ↓
Cria outro Pod
 ↓
3 Pods
```

### Responsabilidade

```text
ReplicaSet
     ↓
Garantir quantidade de Pods
```

---

# 6. Labels

**Labels** são identificadores utilizados para classificar objetos.

Exemplo:

```yaml
metadata:
  labels:
    app: nginx
    environment: production
```

Um Pod pode possuir várias labels:

```text
app=nginx
environment=production
version=v1
team=backend
```

### Para que servem?

Labels permitem que o Kubernetes encontre e agrupe objetos.

Por exemplo:

```text
Pod 1 → app=nginx
Pod 2 → app=nginx
Pod 3 → app=api
```

Podemos buscar:

```bash
kubectl get pods -l app=nginx
```

Resultado:

```text
Pod 1
Pod 2
```

---

# 7. Selectors

**Selectors** são utilizados para selecionar objetos através das labels.

Exemplo:

```yaml
selector:
  matchLabels:
    app: nginx
```

Significa:

```text
Encontre objetos que possuem:

app=nginx
```

### Relação

```text
LABEL
  ↓
app=nginx

SELECTOR
  ↓
procure app=nginx
```

Essa relação é extremamente importante no Kubernetes.

---

# 8. Deployment

O **Deployment** gerencia aplicações stateless e controla ReplicaSets.

A relação é:

```text
Deployment
     ↓
ReplicaSet
     ↓
Pods
```

Exemplo:

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:

    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx
          image: nginx:1.27
```

### O que acontece?

O Deployment cria:

```text
Deployment
     ↓
ReplicaSet
     ↓
3 Pods
```

Se alterarmos a imagem:

```text
nginx:1.27
       ↓
nginx:1.28
```

O Deployment cria uma nova versão do ReplicaSet e realiza o **Rolling Update**.

```text
Deployment
    │
    ├── ReplicaSet antigo
    │      └── Pods antigos
    │
    └── ReplicaSet novo
           └── Pods novos
```

### Responsabilidades

```text
Deployment
 ├── Criação de ReplicaSets
 ├── Atualizações
 ├── Rollback
 ├── Scaling
 └── Controle de versão
```

Comandos:

```bash
kubectl get deployment
kubectl describe deployment nginx
kubectl scale deployment nginx --replicas=5
kubectl rollout status deployment nginx
kubectl rollout history deployment nginx
kubectl rollout undo deployment nginx
```

---

# 9. Services

Pods possuem IPs, mas esses IPs podem mudar.

Exemplo:

```text
Pod A
10.0.0.10

Pod B
10.0.0.11
```

Se o Pod A morrer:

```text
Pod novo
10.0.0.15
```

Não podemos depender diretamente do IP dos Pods.

O **Service** resolve esse problema.

```text
          Service
        10.96.0.10
             │
       ┌─────┴─────┐
       ↓           ↓
     Pod A        Pod B
```

O Service fornece:

* IP estável
* DNS estável
* Descoberta de serviço
* Balanceamento entre Pods

---

# 10. Service + Selector

Um Service normalmente utiliza um selector para encontrar os Pods.

```yaml
apiVersion: v1
kind: Service

metadata:
  name: nginx

spec:
  selector:
    app: nginx

  ports:
    - port: 80
      targetPort: 80
```

O Service procura:

```text
label:

app=nginx
```

Então:

```text
Service
   │
   │ selector: app=nginx
   │
   ├── Pod A
   ├── Pod B
   └── Pod C
```

Se um novo Pod receber:

```yaml
labels:
  app: nginx
```

ele poderá ser incluído automaticamente nos endpoints do Service.

---

# 11. Endpoint

Um **Endpoint** representa os destinos reais para os quais um Service encaminha tráfego.

Exemplo:

```text
Service
   │
   ├── 10.0.0.10:80
   ├── 10.0.0.11:80
   └── 10.0.0.12:80
```

Esses destinos são os endpoints.

Podemos consultar:

```bash
kubectl get endpoints
```

Em Kubernetes modernos, o mecanismo recomendado para representar esses destinos é o **EndpointSlice**:

```bash
kubectl get endpointslices
```

### Relação

```text
Service
   │
   ↓
Selector
   │
   ↓
Labels dos Pods
   │
   ↓
Endpoints / EndpointSlices
   │
   ↓
Pods
```

---

# 12. Fluxo Completo

Uma aplicação típica pode ser representada assim:

```text
                Deployment
                     │
                     ↓
                ReplicaSet
                     │
                     ↓
              ┌──────┴──────┐
              ↓             ↓
            Pod A          Pod B
              │             │
        app=nginx       app=nginx
              └──────┬──────┘
                     ↓
                   Service
                     │
                     ↓
              EndpointSlice
```

---

# 13. Relação entre Labels e Selectors

Essa é uma das relações mais importantes do Kubernetes.

```text
Pod

labels:
  app: nginx
```

↓

```text
Service

selector:
  app: nginx
```

↓

```text
Service encontra o Pod
```

O mesmo conceito é utilizado pelo ReplicaSet/Deployment:

```text
ReplicaSet

selector:
  app: nginx
```

e:

```text
Pod Template

labels:
  app: nginx
```

### Regra mental

```text
LABEL
"Eu sou nginx"

SELECTOR
"Procure quem é nginx"
```

---

# 14. Deployment + ReplicaSet + Pod

```text
Deployment
    │
    │ cria
    ↓
ReplicaSet
    │
    │ gerencia
    ↓
Pods
```

Responsabilidades:

| Recurso    | Responsabilidade                |
| ---------- | ------------------------------- |
| Deployment | Gerenciar versões e ReplicaSets |
| ReplicaSet | Garantir quantidade de Pods     |
| Pod        | Executar containers             |

---

# 15. Service + Endpoint

```text
Service
   │
   │ selector
   ↓
Labels
   │
   ↓
Pods
   │
   ↓
EndpointSlice
```

O Service **não executa containers**.

Ele fornece uma forma estável de acessar os Pods.

---

# 16. Exemplo Completo

## Deployment

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: api

spec:
  replicas: 3

  selector:
    matchLabels:
      app: api

  template:
    metadata:
      labels:
        app: api

    spec:
      containers:
        - name: api
          image: minha-api:1.0
          ports:
            - containerPort: 8080
```

## Service

```yaml
apiVersion: v1
kind: Service

metadata:
  name: api

spec:
  selector:
    app: api

  ports:
    - port: 80
      targetPort: 8080
```

### Resultado

```text
                    Service
                    api:80
                       │
                 selector=api
                       │
          ┌────────────┼────────────┐
          ↓            ↓            ↓
        Pod A        Pod B        Pod C
       app=api      app=api      app=api
          │            │            │
          └────────────┼────────────┘
                       ↓
                EndpointSlices
```

O cliente acessa:

```text
api:80
```

O Kubernetes encaminha para um dos Pods:

```text
api:80
  ↓
Pod A:8080

ou

Pod B:8080

ou

Pod C:8080
```

---

# 17. Comandos Essenciais

```bash
# Pods
kubectl get pods
kubectl describe pod <pod>
kubectl logs <pod>

# Deployment
kubectl get deployments
kubectl describe deployment <name>
kubectl rollout status deployment/<name>
kubectl rollout undo deployment/<name>

# ReplicaSet
kubectl get replicasets
kubectl describe rs <name>

# Labels
kubectl get pods --show-labels
kubectl get pods -l app=api

# Services
kubectl get services
kubectl describe service <name>

# Endpoints
kubectl get endpoints
kubectl get endpointslices

# Objetos
kubectl get all
kubectl get <resource>
kubectl describe <resource> <name>
```

---

# 18. Mapa Mental

```text
                    Kubernetes
                        │
             ┌──────────┴──────────┐
             ↓                     ↓
          Objetos                API
             │                apiVersion
             │
      ┌──────┴───────┐
      ↓              ↓
 Deployment        Service
      │                │
      ↓                ↓
 ReplicaSet        Selector
      │                │
      ↓                ↓
    Pods ←──────── Labels
      │
      ↓
EndpointSlice
```

---

# 19. Resumo

```text
apiVersion
    ↓
Define a versão da API.

Object
    ↓
Representa um recurso do Kubernetes.

Pod
    ↓
Executa containers.

ReplicaSet
    ↓
Mantém a quantidade desejada de Pods.

Deployment
    ↓
Gerencia ReplicaSets, versões e atualizações.

Label
    ↓
Identifica/classifica objetos.

Selector
    ↓
Encontra objetos através das Labels.

Service
    ↓
Fornece acesso estável aos Pods.

Endpoint / EndpointSlice
    ↓
Representa os destinos reais dos Services.
```

### A relação que você deve memorizar

```text
Deployment
     ↓
ReplicaSet
     ↓
Pods
     ↓
Labels
     ↑
Selectors
     ↑
Service
     ↓
EndpointSlice
```

> **Ideia central:** Kubernetes não depende de você controlar diretamente cada Pod. Você declara o estado desejado, e os controladores utilizam objetos, labels e selectors para manter o cluster nesse estado.

Se quiser, posso também transformar esse conteúdo em uma **apostila de Kubernetes do nível básico → intermediário → avançado**, mantendo exatamente esse estilo didático.
