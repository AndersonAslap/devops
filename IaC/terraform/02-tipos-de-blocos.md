# Terraform e HCL — Estrutura Básica de um Projeto Terraform

## Introdução

O **Terraform** é uma ferramenta de **Infraestrutura como Código (Infrastructure as Code - IaC)** criada pela HashiCorp.
Ela permite criar, configurar e gerenciar infraestrutura utilizando código ao invés de realizar configurações manualmente em painéis web de provedores cloud.

Com Terraform, é possível automatizar a criação de:

* Máquinas virtuais
* Redes
* Bancos de dados
* Balanceadores de carga
* Serviços em nuvem
* Recursos em múltiplos provedores cloud

Tudo isso é definido através de arquivos escritos em **HCL (HashiCorp Configuration Language)**.

---

# O que é Infraestrutura como Código (IaC)

Infraestrutura como Código significa que toda a infraestrutura da aplicação é descrita utilizando código.

Ao invés de:

1. Abrir o painel da AWS ou DigitalOcean
2. Clicar manualmente para criar recursos
3. Configurar tudo manualmente

Você escreve arquivos `.tf` contendo a definição da infraestrutura.

Exemplo:

```hcl
resource "digitalocean_droplet" "servidor" {
    image = "ubuntu-20-04-x64"
    name = "meu-servidor"
    region = "nyc1"
    size = "s-1vcpu-2gb"
}
```

Esse código cria automaticamente uma máquina virtual na DigitalOcean.

---

# O que é HCL (HashiCorp Configuration Language)

O Terraform utiliza a linguagem chamada **HCL**.

Ela possui uma sintaxe simples e legível.

Estrutura básica:

```hcl
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
    <IDENTIFIER> = <EXPRESSION>
}
```

## Entendendo a estrutura

### Block Type

Representa o tipo do bloco.

Exemplos:

* `terraform`
* `provider`
* `resource`
* `data`
* `variable`
* `output`

---

### Block Label

É o nome ou identificação do bloco.

Alguns blocos possuem:

* Um label
* Dois labels
* Nenhum label

---

### Identifier

São os parâmetros ou atributos do bloco.

Exemplo:

```hcl
region = "nyc1"
```

Nesse caso:

* `region` → identifier
* `"nyc1"` → expression

---

### Expression

É o valor atribuído ao identificador.

Pode ser:

* Texto
* Número
* Boolean
* Referência a outro recurso
* Variáveis
* Funções

---

# Principais Blocos do Terraform

## 1. Terraform Settings

Esse bloco contém as configurações principais do Terraform.

Exemplo:

```hcl
terraform {
    required_version = ">1.0"

    required_providers {
        digitalocean = {
            source  = "digitalocean/digitalocean"
            version = "2.16.0"
        }
    }
}
```

---

## Para que serve?

Esse bloco é utilizado para:

* Definir a versão mínima do Terraform
* Definir quais providers serão utilizados
* Definir versões dos providers
* Configurar backend remoto
* Configurar estado do Terraform

---

## required_version

Define qual versão do Terraform pode executar o projeto.

Exemplo:

```hcl
required_version = ">1.0"
```

Isso evita problemas de compatibilidade.

### Por que isso é importante?

Imagine que:

* Seu projeto funciona na versão 1.5
* A versão 2.0 remove algum recurso
* O projeto quebra

Ao definir a versão obrigatória, você garante estabilidade.

---

## required_providers

Define quais providers o projeto utilizará.

Exemplo:

```hcl
required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.16.0"
    }
}
```

---

## Entendendo o source

```hcl
source = "digitalocean/digitalocean"
```

Estrutura:

```txt
namespace/provider
```

No exemplo:

* Primeiro `digitalocean` → namespace
* Segundo `digitalocean` → provider

---

## O que é um Provider?

Provider é o componente responsável por permitir que o Terraform converse com:

* AWS
* Azure
* Google Cloud
* DigitalOcean
* Docker
* Kubernetes
* GitHub
* Bancos de dados
* APIs

O provider funciona como uma ponte entre o Terraform e o serviço externo.

---

# 2. Provider Block

O bloco `provider` configura o acesso ao serviço cloud.

Exemplo:

```hcl
provider "digitalocean" {
    token = ""
}
```

---

## O que esse bloco faz?

Ele define:

* Como autenticar
* Qual conta será utilizada
* Região padrão
* Configurações específicas do provider

---

## Token de autenticação

No exemplo:

```hcl
token = ""
```

O token é a chave de acesso da conta DigitalOcean.

O Terraform utilizará esse token para:

* Criar recursos
* Atualizar recursos
* Remover recursos

---

## Terraform como ferramenta Multicloud

Uma grande vantagem do Terraform é o suporte a múltiplos provedores.

No mesmo projeto você pode utilizar:

```hcl
provider "aws" {}
provider "azurerm" {}
provider "digitalocean" {}
```

Isso permite criar infraestrutura em várias nuvens ao mesmo tempo.

---

# 3. Resource Block

O bloco `resource` é o mais importante do Terraform.

Ele representa um recurso real da infraestrutura.

Exemplo:

```hcl
resource "digitalocean_droplet" "maquina_labs_tf" {
    image = "ubuntu-20-04-x64"
    name = "maquina-labs-tf"
    region = "nyc1"
    size = "s-1vcpu-2gb"
}
```

---

# Estrutura do Resource

## Primeiro Label

```hcl
"digitalocean_droplet"
```

Representa o tipo do recurso.

Nesse caso:

* `droplet` = máquina virtual da DigitalOcean

---

## Segundo Label

```hcl
"maquina_labs_tf"
```

É o nome interno do recurso no projeto Terraform.

Esse nome será usado para:

* Referenciar recursos
* Fazer vínculos
* Criar dependências

---

# Configurações do Resource

## image

Sistema operacional da máquina.

```hcl
image = "ubuntu-20-04-x64"
```

---

## name

Nome da máquina virtual.

```hcl
name = "maquina-labs-tf"
```

---

## region

Região onde a máquina será criada.

```hcl
region = "nyc1"
```

---

## size

Define hardware da máquina:

* CPU
* Memória
* Capacidade

```hcl
size = "s-1vcpu-2gb"
```

---

# O que o Resource faz?

Quando executamos:

```bash
terraform apply
```

O Terraform:

1. Lê o código
2. Compara com a infraestrutura atual
3. Cria os recursos necessários
4. Gerencia o estado da infraestrutura

---

# 4. Data Sources

O bloco `data` referencia recursos já existentes.

Exemplo:

```hcl
data "digitalocean_ssh_key" "minha_chave" {
    name = "aula"
}
```

---

# Diferença entre Resource e Data Source

## Resource

Cria e gerencia recursos.

Exemplo:

* Criar máquina virtual
* Criar rede
* Criar banco

---

## Data Source

Apenas consulta recursos já existentes.

Exemplo:

* Buscar uma rede existente
* Buscar uma chave SSH existente
* Buscar uma VPC existente

---

# Exemplo prático

Imagine que:

* Já existe uma rede criada manualmente
* Você deseja conectar uma nova máquina nessa rede

Você não cria outra rede.

Você usa um `data source` para localizar a rede existente.

---

# Chave SSH no exemplo

```hcl
data "digitalocean_ssh_key" "minha_chave" {
    name = "aula"
}
```

Aqui o Terraform:

1. Procura uma chave SSH chamada `aula`
2. Obtém os dados dela
3. Permite usar essa chave em novos recursos

---

# 5. Variables

Variáveis tornam o projeto reutilizável e flexível.

Exemplo:

```hcl
variable "regiao" {
    type = string
    default = "nyc1"
    description = "Região de uso na Digital Ocean"
}
```

---

# Por que usar variáveis?

Sem variáveis:

```hcl
region = "nyc1"
```

Com variáveis:

```hcl
region = var.regiao
```

Agora você pode reutilizar o projeto em diferentes cenários.

---

# Benefícios das Variáveis

## Reaproveitamento

Mesmo projeto para diferentes ambientes:

* Desenvolvimento
* Homologação
* Produção

---

## Flexibilidade

Alterar:

* Região
* Tamanho da máquina
* Sistema operacional
* Quantidade de recursos

Sem alterar o código principal.

---

# Campos principais da variável

## type

Tipo da variável.

Exemplo:

```hcl
type = string
```

---

## default

Valor padrão.

```hcl
default = "nyc1"
```

---

## description

Descrição da variável.

```hcl
description = "Região de uso na Digital Ocean"
```

---

# 6. Outputs

Outputs exibem informações após a execução do Terraform.

Exemplo:

```hcl
output "droplet_ip" {
    value = digitalocean_droplet.maquinalabs_tf.ipv4_address
}
```

---

# Para que serve o Output?

Após criar recursos, geralmente precisamos de informações como:

* IP da máquina
* URL do sistema
* ID do recurso
* Nome do banco
* Endpoint da API

O Output permite retornar essas informações automaticamente.

---

# Exemplo prático

Sem output:

1. Criar máquina
2. Abrir painel cloud
3. Procurar IP manualmente

Com output:

```bash
Apply complete!

Outputs:

droplet_ip = 10.10.10.10
```

Muito mais rápido e automatizado.

---

# Fluxo Básico de um Projeto Terraform

## 1. Configurar Terraform

```hcl
terraform {}
```

---

## 2. Configurar Provider

```hcl
provider {}
```

---

## 3. Criar Recursos

```hcl
resource {}
```

---

## 4. Utilizar Variáveis

```hcl
variable {}
```

---

## 5. Exibir Resultados

```hcl
output {}
```

---

# Exemplo Completo

```hcl
terraform {
    required_version = ">1.0"

    required_providers {
        digitalocean = {
            source  = "digitalocean/digitalocean"
            version = "2.16.0"
        }
    }
}

provider "digitalocean" {
    token = "SEU_TOKEN"
}

variable "regiao" {
    type = string
    default = "nyc1"
}

resource "digitalocean_droplet" "servidor" {
    image  = "ubuntu-20-04-x64"
    name   = "meu-servidor"
    region = var.regiao
    size   = "s-1vcpu-2gb"
}

output "ip_servidor" {
    value = digitalocean_droplet.servidor.ipv4_address
}
```

---

# Resumo

O Terraform é uma ferramenta poderosa para automatizar infraestrutura utilizando código.

Os principais blocos são:

| Bloco       | Função                          |
| ----------- | ------------------------------- |
| `terraform` | Configura Terraform e providers |
| `provider`  | Configura acesso ao cloud       |
| `resource`  | Cria recursos                   |
| `data`      | Consulta recursos existentes    |
| `variable`  | Permite parametrização          |
| `output`    | Exibe resultados                |

---

# Pontos-chave para lembrar

* **Terraform utiliza HCL**
* **Provider conecta o Terraform ao serviço cloud**
* **Resource cria infraestrutura**
* **Data Source consulta recursos existentes**
* **Variables tornam o projeto reutilizável**
* **Outputs exibem informações importantes**
* **Terraform suporta múltiplos provedores cloud**
* **Versionamento evita problemas de compatibilidade**

---

# Conclusão

Com Terraform, é possível automatizar completamente a infraestrutura utilizando código reutilizável e versionável.

Isso traz vantagens como:

* Padronização
* Reprodutibilidade
* Automação
* Escalabilidade
* Controle de mudanças
* Redução de erros manuais

O Terraform se tornou uma das principais ferramentas de DevOps e Cloud atualmente justamente por permitir gerenciar infraestrutura de forma simples, organizada e escalável.
