# 🐳 Guia Completo – Imagens Docker e Dockerfile

## 📌 Sumário

* Construção de imagens
* Gerenciamento de imagens
* Como funciona o build (conceitos importantes)
* Instruções do Dockerfile (detalhado + exemplos)
* Boas práticas com Dockerfile
* Anotações essenciais

---

## 🏗️ Construção de imagens

### ▶️ Build básico

```bash
docker build -t <nome-imagem> -f <caminho-dockerfile> .
```

### 📌 Exemplo real

```bash
docker build -t minha-api:v1 -f Dockerfile .
```

---

### ▶️ Build sem cache

```bash
docker build -t <nome-imagem> -f <dockerfile-path> . --no-cache
```

**Exemplo:**

```bash
docker build -t minha-api:v1 . --no-cache
```

> ⚠️ Ignora todas as camadas em cache → útil para garantir build limpo

---

### 🧠 Explicando os parâmetros

* `-t` → nome + tag da imagem (`nome:versão`)
* `-f` → caminho do Dockerfile (caso não seja o padrão `./Dockerfile`)
* `.` → **contexto de build** (diretório enviado ao Docker daemon)

---

### ⚠️ Contexto de build (IMPORTANTE)

Tudo dentro do `.` será enviado para o Docker daemon.

👉 Use `.dockerignore` para evitar enviar arquivos desnecessários:

```bash
node_modules
.git
.env
```

---

## 📦 Gerenciamento de imagens

### ▶️ Listar imagens

```bash
docker image ls
```

---

### ▶️ Remover imagem

```bash
docker image rm <nome-imagem>
```

**Exemplo:**

```bash
docker image rm minha-api:v1
```

---

### ▶️ Remover imagens não utilizadas

```bash
docker image prune
```

> Remove imagens “dangling” (sem tag)

---

### ▶️ Limpeza mais agressiva

```bash
docker image prune -a
```

> Remove todas as imagens não utilizadas por containers

---

## ⚙️ Como funciona o build (conceitos fundamentais)

### 🧱 Camadas (layers)

* Cada instrução do Dockerfile cria uma **camada**
* As camadas são **cacheadas**
* Se nada mudar → Docker reutiliza o cache

---

### 📌 Exemplo de cache

```dockerfile
COPY package.json .
RUN npm install
COPY . .
```

👉 Se você mudar apenas código, o `npm install` não será executado novamente.

---

### ⚠️ Ordem importa MUITO

Se você fizer isso:

```dockerfile
COPY . .
RUN npm install
```

👉 Qualquer alteração no código invalida o cache → build mais lento

---

## 📜 Instruções do Dockerfile (COMPLETO + EXEMPLOS)

---

### 🧱 `FROM`

Define a imagem base.

```dockerfile
FROM node:18-alpine
```

👉 Sempre é a primeira instrução

---

### ⚙️ `RUN`

Executa comandos durante o build.

```dockerfile
RUN apt-get update && apt-get install -y curl
```

**Boas práticas:**

```dockerfile
RUN apt-get update && apt-get install -y \
    curl \
    git \
 && rm -rf /var/lib/apt/lists/*
```

---

### 📁 `WORKDIR`

Define diretório de trabalho.

```dockerfile
WORKDIR /app
```

👉 Equivalente a `cd /app`

---

### 📋 `COPY`

Copia arquivos locais para a imagem.

```dockerfile
COPY package.json .
COPY . .
```

---

### 📦 `ADD`

Semelhante ao COPY, mas com recursos extras:

* Baixa arquivos remotos
* Extrai arquivos `.tar`

```dockerfile
ADD https://example.com/file.tar.gz /app
```

👉 ⚠️ Evite usar ADD sem necessidade → prefira COPY

---

### 🏷️ `LABEL`

Adiciona metadados.

```dockerfile
LABEL version="1.0"
LABEL maintainer="voce@email.com"
```

---

### 🌎 `ENV`

Define variáveis de ambiente.

```dockerfile
ENV NODE_ENV=production
ENV PORT=3000
```

👉 Pode ser sobrescrito no `docker run`

---

### 🧪 `ARG`

Variável usada apenas no build.

```dockerfile
ARG VERSION=1.0
RUN echo "Versão: $VERSION"
```

**Uso no build:**

```bash
docker build --build-arg VERSION=2.0 .
```

---

### 📦 `VOLUME`

Define ponto de persistência.

```dockerfile
VOLUME ["/data"]
```

---

### 🌐 `EXPOSE`

Documenta a porta da aplicação.

```dockerfile
EXPOSE 3000
```

👉 Não publica a porta automaticamente

---

### 👤 `USER`

Define usuário de execução.

```dockerfile
USER node
```

👉 Boa prática para segurança

---

### ▶️ `CMD`

Define comando padrão.

```dockerfile
CMD ["node", "server.js"]
```

👉 Pode ser sobrescrito no `docker run`

---

### 🚀 `ENTRYPOINT`

Define o comportamento principal do container.

```dockerfile
ENTRYPOINT ["node"]
CMD ["server.js"]
```

👉 Resultado final:

```bash
node server.js
```

---

### ⚔️ Diferença entre CMD e ENTRYPOINT

| CMD                  | ENTRYPOINT              |
| -------------------- | ----------------------- |
| Pode ser sobrescrito | Difícil de sobrescrever |
| Parâmetros padrão    | Executável principal    |

---

## 🧪 Exemplo completo de Dockerfile (Node.js)

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

ENV PORT=3000

EXPOSE 3000

USER node

CMD ["npm", "start"]
```

---

## ⚡ Boas práticas com Dockerfile

### ✅ Use imagens leves

* `alpine` sempre que possível

---

### ✅ Aproveite cache

```dockerfile
COPY package.json .
RUN npm install
COPY . .
```

---

### ✅ Use `.dockerignore`

Evita envio de arquivos desnecessários

---

### ✅ Evite rodar como root

```dockerfile
USER node
```

---

### ✅ Minimize camadas

```dockerfile
RUN apt-get update && apt-get install -y curl
```

---

### ✅ Use multi-stage build (avançado)

```dockerfile
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```

---

## 🧠 Anotações essenciais

* 📦 **Imagem** = template de execução
* 🧱 **Container** = instância da imagem
* 📚 Imagens são compostas por camadas (read-only)
* ✍️ Container adiciona camada de escrita

---

### ⚠️ Cache e ordem

* Mudou uma instrução → invalida todas abaixo
* Sempre coloque instruções mais estáveis no topo

---

### ⚠️ Containers são efêmeros

* Dados somem ao remover container
* Use **volumes** para persistência

---

### 🧪 Regra de ouro

> Dockerfile bom = rápido, pequeno e previsível
