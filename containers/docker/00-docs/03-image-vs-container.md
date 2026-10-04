# 🐳 Imagem vs Container: Fundamentos do Docker

## 🧭 Introdução

Antes de começar a trabalhar com **Docker e containers na prática**, é fundamental entender dois conceitos essenciais:

* **Imagem (Image)**
* **Container**

Esses dois elementos são a base de toda a tecnologia de containers.
Sem esse entendimento, fica difícil avançar para tópicos mais complexos como **Dockerfiles, builds e deploys**.

---

## 🧩 Conceitos principais

### 🔹 Container

* É a **execução de um processo isolado**
* Representa uma **instância em execução**
* É criado a partir de uma imagem

👉 Pense como algo **vivo, rodando**

---

### 🔹 Imagem (Image)

* É um **modelo (template)** para criar containers
* Contém:

  * Sistema de arquivos (filesystem)
  * Dependências
  * Configurações
  * Código da aplicação

👉 Pense como algo **estático, pronto para uso**

---

### 🔹 File System (Sistema de Arquivos)

* Estrutura de diretórios e arquivos
* Inclui:

  * Binários
  * Bibliotecas
  * Configurações

👉 É a base que permite o container rodar corretamente

---

## 📖 Explicação detalhada

## 🧠 Relação entre Imagem e Container

A relação é simples e fundamental:

```plaintext
Imagem → gera → Container(s)
```

Ou seja:

* Uma **imagem** pode gerar **vários containers**
* Cada container é uma **instância independente**

---

## 🏗️ Analogia com o mundo real

### 🏢 Construção civil

* **Imagem** → Planta (blueprint) do prédio
* **Container** → Prédio construído

👉 Com a mesma planta, você pode construir:

* 1 prédio
* 10 prédios
* 100 prédios

---

### 💻 Programação Orientada a Objetos (POO)

* **Imagem** → Classe
* **Container** → Objeto (instância)

```java
// Classe (imagem)
class App {
    void run() {
        System.out.println("Executando aplicação");
    }
}

// Objetos (containers)
App app1 = new App();
App app2 = new App();
```

👉 Cada objeto é independente, mas vem da mesma definição.

---

## 📦 O que existe dentro de uma imagem?

Uma imagem contém tudo que é necessário para executar uma aplicação:

* Sistema base (ex: Linux mínimo)
* Bibliotecas
* Dependências
* Código da aplicação
* Variáveis de ambiente
* Configurações

---

### 🔍 Exemplo prático (conceitual)

Uma imagem de uma API Node.js pode conter:

```plaintext
/ (root)
 ├── app/
 │   ├── index.js
 ├── node_modules/
 ├── package.json
 ├── libs/
 └── configurações do ambiente
```

👉 Tudo isso será usado para criar o container.

---

## ⚙️ Como um container é criado?

O processo é:

1. Você tem uma **imagem**
2. O container runtime (ex: Docker) usa essa imagem
3. Um **container é criado e executado**

```bash
docker run minha-imagem
```

👉 Isso cria e inicia um container baseado na imagem.

---

## 🔁 Um para muitos

Uma única imagem pode gerar vários containers:

```plaintext
Imagem: minha-api

   ↓ cria ↓

Container 1 (porta 3000)
Container 2 (porta 3001)
Container 3 (porta 3002)
```

👉 Muito útil para:

* Escalabilidade
* Testes
* Balanceamento de carga

---

## ⚠️ Diferença essencial

| Característica | Imagem                | Container             |
| -------------- | --------------------- | --------------------- |
| Tipo           | Estático              | Dinâmico              |
| Estado         | Não executa           | Em execução           |
| Função         | Modelo/template       | Instância             |
| Alterações     | Imutável (geralmente) | Pode mudar em runtime |

---

## 🧠 Conceito importante: Imutabilidade

* A **imagem não muda**
* Sempre que algo precisa mudar:

  * Você cria uma **nova imagem**

👉 Isso garante:

* Reprodutibilidade
* Consistência entre ambientes

---

## 🔬 Relação com isolamento (contexto avançado)

A imagem contém o **filesystem isolado**, que será usado pelo container.

Esse isolamento é possível graças a tecnologias do Linux como:

* **Namespaces** → isolam processos
* **cgroups** → controlam recursos

👉 O container usa a imagem como base para criar esse ambiente isolado.

---

## 💡 Exemplos

### Exemplo 1: Criando múltiplos containers

```bash
docker run nginx
docker run nginx
docker run nginx
```

👉 Você terá vários containers rodando a partir da mesma imagem do Nginx.

---

### Exemplo 2: Ambiente consistente

* Dev cria uma imagem
* Envia para produção
* Produção roda container

👉 Resultado:
**Funciona exatamente igual**

---

## 🧾 Resumo

* **Imagem** é o modelo (template)
* **Container** é a instância em execução
* Uma imagem pode gerar vários containers
* A imagem contém tudo necessário para execução
* Containers são efêmeros e dinâmicos

---

## 📌 Pontos-chave para lembrar

* Imagem = **classe / blueprint**
* Container = **objeto / instância**
* Imagem é **imutável**
* Container é **executável**
* Um container sempre nasce de uma imagem