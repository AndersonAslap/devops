# 🐳 Guia Básico de Containers com Docker

## 📌 Sumário

* Criando e listando containers
* Interagindo com o container
* Executando containers continuamente
* Publicando portas (port binding)
* Variáveis de ambiente em containers
* Anotações importantes

---

## 🚀 Criando e listando containers

### ▶️ Criar um container

```bash
docker container run <imagem>
```

**Exemplo:**

```bash
docker container run nginx
```

> Cria e inicia um container com a imagem do Nginx.

---

### ▶️ Criar container com nome

```bash
docker container run --name <nome> <imagem>
```

**Exemplo:**

```bash
docker container run --name meu-nginx nginx
```

---

### 📋 Listar containers em execução

```bash
docker container ls
```

---

### 📋 Listar todos os containers (inclusive parados)

```bash
docker container ls -a
```

---

### 🗑️ Remover containers

```bash
docker container rm <container1> <container2>
```

**Exemplo:**

```bash
docker container rm meu-nginx container-teste
```

---

### 🗑️ Remover containers forçando parada

```bash
docker container rm -f <container1> <container2>
```

---

### 🧹 Remover todos os containers

```bash
docker container rm -f $(docker container ls -qa)
```

---

### ▶️ Iniciar um container parado

```bash
docker container start <container>
```

**Exemplo:**

```bash
docker container start meu-nginx
```

---

### 📜 Visualizar logs do container

```bash
docker logs <container>
```

**Exemplo:**

```bash
docker logs meu-nginx
```

---

## 💻 Interagindo com o container

### ▶️ Executar container em modo interativo (terminal)

```bash
docker container run -it <imagem> /bin/bash
```

**Exemplo:**

```bash
docker container run -it ubuntu /bin/bash
```

> Abre um terminal dentro do container Ubuntu.

---

### ▶️ Executar container e removê-lo automaticamente

```bash
docker container run --rm -it <imagem> /bin/bash
```

**Exemplo:**

```bash
docker container run --rm -it ubuntu /bin/bash
```

> O container será apagado automaticamente ao sair.

---

### ▶️ Executar comando em container já existente

```bash
docker exec -it <container> /bin/bash
```

**Exemplo:**

```bash
docker exec -it meu-nginx /bin/bash
```

---

## 🔁 Executando containers continuamente

### ▶️ Modo detached (background)

```bash
docker container run -d <imagem>
```

**Exemplo:**

```bash
docker container run -d nginx
```

> O container roda em segundo plano.

---

## 🌐 Publicando portas (Port Binding)

### ▶️ Mapear porta local para o container

```bash
docker container run -d -p <porta-local>:<porta-container> <imagem>
```

**Exemplo:**

```bash
docker container run -d -p 8080:80 nginx
```

> Acesse no navegador:
> 👉 [http://localhost:8080](http://localhost:8080)

---

## ⚙️ Variáveis de ambiente em containers

### ▶️ Definir variáveis de ambiente

```bash
docker container run -e <variavel>=<valor> <imagem>
```

**Exemplo:**

```bash
docker container run -e MYSQL_ROOT_PASSWORD=123456 mysql
```

---

### ▶️ Múltiplas variáveis

```bash
docker container run \
  -e APP_ENV=production \
  -e APP_PORT=3000 \
  minha-app
```

---

## 🧠 Anotações importantes

### 📌 Diferença entre `run` e `exec`

* `docker container run`
  → Cria e inicia um novo container

* `docker exec`
  → Executa comandos dentro de um container já existente

---

### 📌 Documentação das imagens

Sempre consulte o registry oficial (ex: Docker Hub) para verificar:

* Variáveis de ambiente obrigatórias
* Portas utilizadas
* Volumes necessários

---

### 📌 Containers são efêmeros

> Um container **não mantém dados permanentemente** por padrão.

* Ao remover o container → os dados são perdidos
* Para persistência → use **volumes**

---

### 📌 Boas práticas

* Nomeie seus containers (`--name`)
* Use `--rm` para containers temporários
* Documente variáveis de ambiente
* Evite rodar containers sem necessidade em modo root
