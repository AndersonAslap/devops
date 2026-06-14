# Terraform Modules (Módulos no Terraform)

## Visão Geral

Os módulos são um dos recursos mais importantes do Terraform e representam uma das principais práticas utilizadas por profissionais DevOps e Cloud Engineers em ambientes corporativos.

Um módulo permite encapsular uma parte da infraestrutura em uma unidade reutilizável, organizada e padronizada.

Em vez de repetir código diversas vezes, podemos criar um módulo uma única vez e reutilizá-lo em vários projetos.

---

## Objetivos de Aprendizagem

Ao final deste material você será capaz de:

* Entender o conceito de módulos no Terraform.
* Compreender a diferença entre módulo raiz e módulo filho.
* Identificar quando criar um módulo.
* Estruturar corretamente um módulo Terraform.
* Consumir módulos locais.
* Consumir módulos remotos.
* Entender boas práticas de documentação.
* Criar infraestruturas reutilizáveis e escaláveis.

---

# Introdução

Conforme os ambientes crescem, a infraestrutura também cresce.

Um ambiente corporativo moderno pode possuir:

* Bancos de dados
* Clusters Kubernetes
* Filas de mensagens
* Máquinas virtuais
* Balanceadores de carga
* Serviços de monitoramento
* Serviços de cache
* Serviços de armazenamento

Imagine um projeto contendo:

```text
Kubernetes
Prometheus
Grafana
Redis
RabbitMQ
PostgreSQL
20 Microserviços
```

Criar tudo isso em um único arquivo Terraform rapidamente se torna inviável.

O código cresce.

A manutenção se torna difícil.

O reaproveitamento praticamente desaparece.

É exatamente nesse problema que os módulos entram.

---

# O Problema Que os Módulos Resolvem

Sem módulos:

```text
main.tf
│
├── Cluster Kubernetes
├── PostgreSQL
├── Redis
├── RabbitMQ
├── Prometheus
├── Grafana
├── Microserviços
└── Load Balancers
```

Resultado:

```text
Arquivo gigante
Difícil manutenção
Pouco reaproveitamento
Maior chance de erros
```

---

# O Que é um Módulo?

Um módulo é um conjunto de recursos Terraform agrupados para executar uma função específica.

Podemos pensar nele como uma "caixa preta".

---

## Analogia com Programação

Se você já programa, o conceito será muito familiar.

### Em programação

```typescript
function criarUsuario() {
    ...
}
```

ou

```csharp
public class UsuarioService
{
}
```

Você encapsula uma responsabilidade.

---

### Em Terraform

```hcl
module "kubernetes" {

}
```

Você encapsula uma parte da infraestrutura.

---

## Comparação

| Programação  | Terraform    |
| ------------ | ------------ |
| Função       | Módulo       |
| Método       | Módulo       |
| Classe       | Módulo       |
| Biblioteca   | Módulo       |
| Reutilização | Reutilização |

---

# Quando Criar um Módulo?

Uma excelente pergunta é:

> "Como saber se algo deve virar um módulo?"

Regra prática:

Se você consegue dar um nome para um conjunto de recursos, provavelmente aquilo pode ser um módulo.

---

## Exemplos

### Kubernetes Stack

```text
Cluster Kubernetes
Node Pools
Ingress
Monitoramento
```

Módulo:

```text
kubernetes-stack
```

---

### WordPress Stack

```text
VM
Banco de Dados
Nginx
SSL
```

Módulo:

```text
wordpress-stack
```

---

### Banco PostgreSQL

```text
Servidor
Storage
Backup
Firewall
```

Módulo:

```text
postgresql
```

---

# Benefícios dos Módulos

## Reutilização

Criar uma vez.

Utilizar várias vezes.

---

## Padronização

Todos os ambientes seguem o mesmo padrão.

---

## Organização

Infraestrutura dividida em partes menores.

---

## Escalabilidade

Mais fácil evoluir grandes ambientes.

---

## Compartilhamento

Times inteiros podem reutilizar módulos.

---

# Estrutura de Módulos no Terraform

Terraform trabalha com dois conceitos principais:

## Módulo Raiz (Root Module)

É o projeto principal.

Sempre existe.

---

### Exemplo

```text
infraestrutura/
│
├── main.tf
├── variables.tf
├── outputs.tf
└── providers.tf
```

Todo projeto Terraform já é um módulo raiz.

---

## Módulos Filhos (Child Modules)

São módulos consumidos pelo módulo raiz.

---

### Exemplo

```text
infraestrutura/
│
├── main.tf
│
└── modules/
    │
    ├── kubernetes/
    │
    ├── postgresql/
    │
    └── redis/
```

---

# Hierarquia de Módulos

Um módulo pode conter outros módulos.

```text
Root Module
    │
    ├── Kubernetes Module
    │       │
    │       ├── Monitoring Module
    │       ├── Ingress Module
    │       └── Logging Module
    │
    └── Database Module
            │
            ├── Backup Module
            └── Security Module
```

---

# Estrutura Recomendada de um Módulo

## Estrutura Simples

```text
kubernetes-module/
│
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

## Estrutura Profissional

```text
kubernetes-module/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── versions.tf
├── README.md
├── LICENSE
│
├── modules/
│   │
│   ├── monitoring/
│   ├── ingress/
│   └── logging/
│
└── examples/
    │
    ├── basic/
    └── complete/
```

---

# Função de Cada Arquivo

## main.tf

Contém os recursos.

```hcl
resource "..."
{
}
```

---

## variables.tf

Define entradas do módulo.

```hcl
variable "cluster_name" {
}
```

---

## outputs.tf

Define saídas.

```hcl
output "cluster_id" {
}
```

---

## README.md

Documentação.

---

## LICENSE

Licença de uso.

---

## examples

Exemplos de implementação.

---

# Importância da Documentação

Imagine este módulo:

```text
module "kubernetes" {
}
```

Sem documentação:

```text
❌ Quais parâmetros existem?
❌ Quais são obrigatórios?
❌ O que o módulo cria?
```

---

Com documentação:

```text
✅ Fácil utilização
✅ Fácil manutenção
✅ Fácil adoção
```

---

# Consumindo um Módulo

Para utilizar um módulo utilizamos o bloco:

```hcl
module
```

---

## Estrutura Básica

```hcl
module "nome_do_modulo" {

  source = "./modules/modulo"

}
```

---

# Anatomia do Bloco Module

## Nome

```hcl
module "kubernetes"
```

Identificador dentro do projeto.

---

## Source

```hcl
source = "./modules/kubernetes"
```

Localização do módulo.

---

## Variáveis

```hcl
module "kubernetes" {

  source = "./modules/kubernetes"

  cluster_name = "cluster-prod"

}
```

---

# Fluxo de Funcionamento

```text
Root Module
      │
      ▼
module "kubernetes"
      │
      ▼
Carrega módulo
      │
      ▼
Executa recursos internos
      │
      ▼
Retorna outputs
```

---

# Tipos de Source

## Módulo Local

```hcl
source = "./modules/kubernetes"
```

---

## GitHub

```hcl
source = "git::https://github.com/empresa/kubernetes-module.git"
```

---

## Branch Específica

```hcl
source = "git::https://github.com/empresa/kubernetes-module.git?ref=develop"
```

---

## Tag

```hcl
source = "git::https://github.com/empresa/kubernetes-module.git?ref=v1.0.0"
```

---

## Terraform Registry

```hcl
source = "terraform-aws-modules/vpc/aws"
```

---

# Controle de Versão

Sempre utilize versões.

---

## Exemplo

```hcl
module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"

  version = "5.1.0"

}
```

---

## Benefício

Evita que atualizações inesperadas quebrem seu ambiente.

---

# Meta-Argumentos em Módulos

Os mesmos meta-argumentos utilizados em recursos também funcionam em módulos.

---

## Count

Criar múltiplas instâncias.

```hcl
module "vm" {

  count = 3

}
```

---

## For Each

Criar múltiplas instâncias baseadas em coleção.

```hcl
module "vm" {

  for_each = var.environments

}
```

---

## Depends On

Controlar dependências.

```hcl
module "kubernetes" {

  depends_on = [
    module.network
  ]

}
```

---

## Providers

Definir provider específico.

```hcl
module "kubernetes" {

  providers = {
    aws = aws.us-east-1
  }

}
```

---

# Exemplo Prático

## Estrutura

```text
infra/
│
├── main.tf
│
└── modules/
    │
    └── local-file/
        │
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## Módulo

### variables.tf

```hcl
variable "content" {
  type = string
}

variable "filename" {
  type = string
}
```

---

### main.tf

```hcl
resource "local_file" "arquivo" {

  content  = var.content

  filename = var.filename

}
```

---

## Consumo

```hcl
module "arquivo_teste" {

  source = "./modules/local-file"

  content  = "Olá Terraform"

  filename = "teste.txt"

}
```

---

# Boas Práticas

## Um módulo deve ter uma responsabilidade

Correto:

```text
Kubernetes Module
```

Errado:

```text
Kubernetes + PostgreSQL + Redis + RabbitMQ
```

---

## Sempre documente

Utilize:

```text
README.md
```

---

## Crie exemplos

```text
examples/basic
examples/complete
```

---

## Versione seus módulos

Utilize tags.

```text
v1.0.0
v1.1.0
v2.0.0
```

---

## Evite dependências ocultas

Tudo que o módulo precisa deve ser explicitamente declarado.

---

# Resumo

Terraform Modules são o principal mecanismo de reutilização de código da ferramenta.

Eles permitem:

* Organizar infraestrutura
* Reaproveitar código
* Padronizar ambientes
* Facilitar manutenção
* Escalar projetos corporativos

Os principais conceitos estudados foram:

* Root Module
* Child Module
* Estrutura de diretórios
* Documentação
* Source
* Versionamento
* Registry
* Git
* Meta-argumentos
* Reutilização

Dominar módulos é um dos diferenciais mais importantes para atuar profissionalmente com Terraform em ambientes de produção e arquiteturas de grande escala.

---

# Criando e Consumindo Módulos no Terraform

## Visão Geral

Agora que entendemos o conceito de módulos, vamos aprender na prática como transformar um conjunto de recursos Terraform em um módulo reutilizável.

Neste exemplo, iremos:

1. Criar uma infraestrutura simples.
2. Transformar essa infraestrutura em um módulo.
3. Consumir o módulo através do módulo raiz.
4. Entender a estrutura de diretórios utilizada pelo Terraform.

Este é exatamente o mesmo processo utilizado em ambientes corporativos para encapsular:

* Clusters Kubernetes
* Bancos de dados
* Redes VPC/VNet
* Balanceadores de carga
* Ambientes completos de aplicações

---

## Objetivos de Aprendizagem

Ao final deste material você será capaz de:

* Criar módulos Terraform.
* Organizar recursos dentro de módulos.
* Criar a estrutura de diretórios adequada.
* Consumir módulos locais.
* Entender a relação entre módulo raiz e módulo filho.
* Reutilizar infraestrutura através de módulos.

---

# Introdução

Antes de utilizar módulos, nossa infraestrutura era composta por quatro recursos:

```text
main.tf
│
├── random_pet.pet1
├── random_pet.pet2
├── local_file.file1
└── local_file.file2
```

Todos os recursos estavam concentrados em um único arquivo.

Embora funcione, essa abordagem apresenta problemas quando o projeto cresce.

---

## Problema

Imagine que você precise criar esse mesmo conjunto de recursos em diversos projetos.

Sem módulos:

```text
Projeto A
 └── Copia código

Projeto B
 └── Copia código

Projeto C
 └── Copia código
```

Resultado:

```text
❌ Duplicação de código
❌ Maior manutenção
❌ Maior chance de erros
```

---

## Solução

Criar um módulo reutilizável.

```text
Projeto A
      │
Projeto B
      ├──► Módulo Pets
      │
Projeto C
```

Agora existe apenas uma implementação.

---

# Estrutura Inicial do Projeto

Antes da modularização:

```text
terraform-project/
│
└── main.tf
```

---

## Recursos Existentes

O projeto possui:

### Recursos Random Pet

Responsáveis por gerar nomes aleatórios.

```hcl
resource "random_pet" "pet1" {

}
```

```hcl
resource "random_pet" "pet2" {

}
```

---

### Recursos Local File

Responsáveis por criar arquivos.

```hcl
resource "local_file" "file1" {

}
```

```hcl
resource "local_file" "file2" {

}
```

---

## Fluxo de Execução

```text
Terraform Apply
      │
      ▼
Cria Pet 1
      │
      ▼
Cria Pet 2
      │
      ▼
Cria Arquivo 1
      │
      ▼
Cria Arquivo 2
```

---

# Executando o Projeto Original

## Inicialização

```bash
terraform init
```

---

## Aplicação

```bash
terraform apply
```

---

## Resultado

```text
arquivo1.txt
 └── nome do pet

arquivo2.txt
 └── nome do pet
```

Exemplo:

```text
calm-rabbit
bright-dog
```

---

# Transformando em um Módulo

Antes de criar o módulo é recomendado destruir a infraestrutura existente.

## Destroy

```bash
terraform destroy
```

---

## Motivo

Vamos reorganizar o projeto.

Isso evita inconsistências durante a refatoração.

---

# Criando a Estrutura de Diretórios

Primeiro criamos uma pasta chamada:

```text
modules
```

Dentro dela:

```text
modules/
└── pets/
```

---

## Estrutura

```text
terraform-project/
│
├── modules/
│   │
│   └── pets/
│
└── main.tf
```

---

# Criando o Módulo Pets

Agora pegamos todo o conteúdo do arquivo original.

---

## Antes

```text
main.tf
│
├── random_pet.pet1
├── random_pet.pet2
├── local_file.file1
└── local_file.file2
```

---

## Depois

```text
modules/
└── pets/
    │
    └── main.tf
```

---

## Resultado

```text
terraform-project/
│
├── modules/
│   │
│   └── pets/
│       │
│       └── main.tf
│
└── main.tf
```

---

# Entendendo a Mudança

Antes:

```text
main.tf
```

era o:

```text
Root Module
```

---

Depois:

```text
modules/pets/main.tf
```

passa a ser:

```text
Child Module
```

---

E precisamos criar um novo:

```text
Root Module
```

que irá consumir esse módulo.

---

# Criando o Novo Main.tf

Agora criamos novamente:

```text
terraform-project/
│
└── main.tf
```

---

## Conteúdo

```hcl
module "pets" {

  source = "./modules/pets"

}
```

---

# Entendendo o Código

## Nome do Módulo

```hcl
module "pets"
```

É o identificador do módulo dentro do projeto.

---

## Source

```hcl
source = "./modules/pets"
```

Indica onde o Terraform deve encontrar o módulo.

---

### Que caminho é esse?

```text
.
```

significa:

```text
Diretório atual
```

Portanto:

```text
./modules/pets
```

significa:

```text
Diretório Atual
     │
     ▼
modules
     │
     ▼
pets
```

---

# Estrutura Final

```text
terraform-project/
│
├── main.tf
│
└── modules/
    │
    └── pets/
        │
        └── main.tf
```

---

# Fluxo de Funcionamento

```text
Root Module
    │
    ▼
module "pets"
    │
    ▼
modules/pets
    │
    ▼
random_pet.pet1

random_pet.pet2

local_file.file1

local_file.file2
```

---

# Reexecutando o Projeto

Após adicionar módulos, precisamos executar novamente:

```bash
terraform init
```

---

## Por Que?

O Terraform precisa:

* Descobrir os módulos utilizados.
* Baixar dependências.
* Atualizar a estrutura interna.

---

## Fluxo

```text
terraform init
      │
      ▼
Identifica módulo
      │
      ▼
Carrega módulo
      │
      ▼
Atualiza configuração
```

---

# Aplicando a Infraestrutura

```bash
terraform apply
```

---

## Resultado

O Terraform executará:

```text
module.pets.random_pet.pet1

module.pets.random_pet.pet2

module.pets.local_file.file1

module.pets.local_file.file2
```

---

## Observe

Agora os recursos pertencem ao módulo.

Antes:

```text
random_pet.pet1
```

Agora:

```text
module.pets.random_pet.pet1
```

---

# Comparação Antes e Depois

## Sem Módulo

```text
main.tf

300 linhas
500 linhas
1000 linhas
```

---

## Com Módulo

```hcl
module "pets" {

  source = "./modules/pets"

}
```

---

Resultado:

```text
✔ Mais organizado
✔ Mais reutilizável
✔ Mais legível
✔ Mais profissional
```

---

# Analogia com Programação

Sem módulo:

```csharp
// Código repetido
// Código repetido
// Código repetido
```

---

Com módulo:

```csharp
CriarPets();
```

---

Terraform:

```hcl
module "pets" {

  source = "./modules/pets"

}
```

---

# Boas Práticas

## Um módulo deve ter responsabilidade única

Correto:

```text
pets
```

ou

```text
kubernetes
```

ou

```text
postgresql
```

---

Errado:

```text
infraestrutura-completa
```

Misturando dezenas de responsabilidades.

---

## Organize os módulos em uma pasta específica

```text
modules/
```

---

## Utilize nomes descritivos

Prefira:

```text
kubernetes
postgresql
redis
rabbitmq
```

Evite:

```text
modulo1
teste
infra
```

---

## Pense em reutilização

Pergunte sempre:

> "Eu usaria isso novamente em outro projeto?"

Se a resposta for sim, provavelmente deve ser um módulo.

---

# Resumo

Neste exemplo aprendemos como transformar uma infraestrutura comum em um módulo reutilizável.

O processo consistiu em:

1. Criar os recursos normalmente.
2. Criar a pasta `modules`.
3. Criar a pasta `pets`.
4. Mover os recursos para o módulo.
5. Criar um novo módulo raiz.
6. Consumir o módulo utilizando:

```hcl
module "pets" {

  source = "./modules/pets"

}
```

Esse é o primeiro passo para construir infraestruturas profissionais, organizadas e reutilizáveis utilizando Terraform Modules. Nas próximas etapas, veremos como parametrizar módulos através de variáveis e utilizá-los em cenários reais com provedores de nuvem como a DigitalOcean.

---

# Terraform Modules — Variáveis e Outputs

## Visão Geral

Após criar um módulo, o próximo passo é torná-lo flexível e reutilizável.

Um módulo que não recebe parâmetros é limitado, pois sempre executará da mesma forma.

Para resolver isso, utilizamos:

* **Variáveis (Inputs)** → permitem personalizar o comportamento do módulo.
* **Outputs** → permitem expor informações geradas pelo módulo para outros módulos ou para o módulo raiz.

Esses dois conceitos transformam um simples agrupamento de recursos em um componente reutilizável de infraestrutura.

---

## Objetivos de Aprendizagem

Ao final deste material você será capaz de:

* Criar variáveis em módulos.
* Receber parâmetros do módulo raiz.
* Utilizar valores dinâmicos dentro do módulo.
* Criar outputs em módulos.
* Expor informações para o módulo raiz.
* Entender o fluxo de comunicação entre módulos.

---

# Introdução

Até agora criamos o módulo:

```text
modules/
└── pets/
```

Responsável por:

* Gerar nomes aleatórios de pets.
* Criar arquivos.
* Armazenar os nomes gerados.

O problema é que tudo está fixo.

Por exemplo:

```hcl
content = random_pet.pet_1.id
```

Não existe nenhuma forma de personalizar o conteúdo.

Para tornar o módulo mais reutilizável, precisamos parametrizá-lo.

---

# Entradas e Saídas de um Módulo

Podemos pensar em um módulo como uma função.

---

## Analogia com Programação

### Função

```csharp
string GerarNome(string prefixo)
{
    return prefixo + " João";
}
```

Entrada:

```text
prefixo
```

Saída:

```text
João
```

---

### Terraform

Entrada:

```hcl
variable "prefixo_arquivo"
```

Saída:

```hcl
output "nome_pet_01"
```

---

# Fluxo de Comunicação

```text
Módulo Raiz
      │
      │ envia variável
      ▼
Módulo Filho
      │
      │ processa
      ▼
Outputs
      │
      │ retorna valores
      ▼
Módulo Raiz
```

---

# Criando Variáveis no Módulo

## Arquivo variables.tf

Dentro do módulo:

```text
modules/
└── pets/
    ├── main.tf
    ├── variables.tf
```

Criamos:

```hcl
variable "prefixo_arquivo" {

}
```

---

## O Que Essa Variável Faz?

Ela permitirá definir um texto inicial para o conteúdo dos arquivos.

Por exemplo:

```text
PET:
```

ou

```text
Nome:
```

ou

```text
Arquivo Gerado:
```

---

# Utilizando a Variável

Agora utilizamos a variável dentro do módulo.

---

## Antes

```hcl
content = random_pet.pet_1.id
```

---

## Depois

```hcl
content = "${var.prefixo_arquivo} ${random_pet.pet_1.id}"
```

---

Mesma ideia para o segundo arquivo:

```hcl
content = "${var.prefixo_arquivo} ${random_pet.pet_2.id}"
```

---

# Consumindo a Variável

No módulo raiz:

```hcl
module "pets" {

  source = "./modules/pets"

  prefixo_arquivo = "Teste de Arquivo"

}
```

---

# Fluxo de Execução

```text
Root Module
      │
      ▼
prefixo_arquivo
      │
      ▼
Módulo Pets
      │
      ▼
Cria conteúdo
      │
      ▼
Teste de Arquivo + Nome do Pet
```

---

# Resultado

Antes:

```text
happy-cat
```

Depois:

```text
Teste de Arquivo happy-cat
```

---

# Por Que Isso é Importante?

Sem variáveis:

```text
Módulo rígido
```

Com variáveis:

```text
Módulo configurável
```

---

## Exemplo de Reutilização

### Ambiente Desenvolvimento

```hcl
module "pets_dev" {

  source = "./modules/pets"

  prefixo_arquivo = "DEV"

}
```

---

### Ambiente Produção

```hcl
module "pets_prod" {

  source = "./modules/pets"

  prefixo_arquivo = "PROD"

}
```

---

Resultado:

```text
DEV happy-cat
PROD happy-cat
```

Mesmo módulo.

Comportamentos diferentes.

---

# A Importância da Documentação

Ao criar variáveis, você deve documentá-las.

---

## README.md

Exemplo:

```markdown
## Variáveis

| Nome | Tipo | Obrigatório | Descrição |
|--------|--------|------------|------------|
| prefixo_arquivo | string | Sim | Prefixo utilizado no conteúdo dos arquivos |
```

---

Sem documentação:

```text
❌ Difícil utilização
❌ Difícil manutenção
```

---

Com documentação:

```text
✅ Fácil adoção
✅ Fácil entendimento
```

---

# Criando Outputs

Agora queremos expor informações criadas pelo módulo.

---

## Problema

Temos:

```hcl
resource "random_pet" "pet_1"
```

e

```hcl
resource "random_pet" "pet_2"
```

Mas quem utiliza o módulo não consegue acessar diretamente esses recursos.

---

## Motivo

Módulos funcionam como encapsulamento.

Os recursos internos ficam protegidos.

---

# Analogia com Programação

```csharp
public class Usuario
{
    private string senha;
}
```

Não conseguimos acessar diretamente:

```csharp
usuario.senha
```

---

Precisamos expor:

```csharp
GetSenha();
```

---

No Terraform fazemos isso com:

```hcl
output
```

---

# Criando Outputs no Módulo Filho

## outputs.tf

```hcl
output "nome_01" {

  value = random_pet.pet_1.id

}
```

---

Segundo output:

```hcl
output "nome_02" {

  value = random_pet.pet_2.id

}
```

---

# O Que Está Sendo Exposto?

Observe:

```hcl
random_pet.pet_1.id
```

Estamos expondo apenas:

```text
ID
```

---

## Por Que Utilizar .id?

Se utilizarmos:

```hcl
value = random_pet.pet_1
```

O Terraform tentará expor o recurso inteiro.

Exemplo:

```json
{
  "id": "happy-cat",
  "length": 2,
  "separator": "-"
}
```

---

Na maioria dos casos queremos apenas:

```text
happy-cat
```

Por isso:

```hcl
value = random_pet.pet_1.id
```

---

# Por Que o Output Não Apareceu?

Muitos iniciantes cometem esse erro.

Criam o output dentro do módulo:

```hcl
output "nome_01"
```

Executam:

```bash
terraform apply
```

E esperam ver:

```text
happy-cat
```

Mas nada aparece.

---

## O Motivo

O output foi criado dentro do módulo filho.

Não no módulo raiz.

---

# Encapsulamento de Módulos

```text
Root Module
      │
      ▼
Module Pets
      │
      ▼
Output nome_01
```

O output existe.

Mas ainda está dentro do módulo.

---

# Expondo o Output no Módulo Raiz

Criamos:

```hcl
output "nome_pet_01" {

}
```

---

Agora acessamos:

```hcl
module.pets.nome_01
```

---

Exemplo completo:

```hcl
output "nome_pet_01" {

  value = module.pets.nome_01

}
```

---

Segundo output:

```hcl
output "nome_pet_02" {

  value = module.pets.nome_02

}
```

---

# Como Funciona a Referência

## Recursos

```hcl
resource.tipo.nome
```

Exemplo:

```hcl
random_pet.pet_1.id
```

---

## Módulos

```hcl
module.nome.output
```

Exemplo:

```hcl
module.pets.nome_01
```

---

# Fluxo Completo

```text
random_pet.pet_1
        │
        ▼
output nome_01
        │
        ▼
module.pets.nome_01
        │
        ▼
output nome_pet_01
        │
        ▼
Terminal Terraform
```

---

# Resultado Final

Após executar:

```bash
terraform apply
```

Saída:

```text
Outputs:

nome_pet_01 = "happy-cat"

nome_pet_02 = "silent-rabbit"
```

---

# Boas Práticas

## Sempre tipar variáveis

```hcl
variable "prefixo_arquivo" {

  type = string

}
```

---

## Sempre documentar variáveis

Adicionar no README:

```markdown
Variáveis
Outputs
Exemplos
```

---

## Expor apenas o necessário

Correto:

```hcl
value = random_pet.pet_1.id
```

Evite:

```hcl
value = random_pet.pet_1
```

quando o recurso completo não for necessário.

---

## Utilizar nomes descritivos

Bom:

```hcl
nome_pet_01
```

Ruim:

```hcl
valor1
```

---

# Resumo

Neste capítulo aprendemos como tornar módulos reutilizáveis utilizando variáveis e outputs.

### Variáveis (Inputs)

Permitem receber informações do módulo raiz:

```hcl
variable "prefixo_arquivo"
```

Consumidas através de:

```hcl
var.prefixo_arquivo
```

---

### Outputs

Permitem expor informações geradas pelo módulo:

```hcl
output "nome_01"
```

---

### Acesso aos Outputs

Dentro do módulo raiz:

```hcl
module.pets.nome_01
```

---

Fluxo final:

```text
Input
  ↓
Variable
  ↓
Módulo
  ↓
Output
  ↓
Root Module
  ↓
Terraform Apply
```

Esse mecanismo de entrada e saída é a base para a construção de módulos profissionais, reutilizáveis e compartilháveis em ambientes corporativos utilizando Terraform.

---

# Terraform Modules — Reutilização, Múltiplas Instâncias e Dependências

## Visão Geral

Uma das maiores vantagens dos módulos Terraform é a capacidade de reutilização.

Depois que um módulo é criado, ele pode ser utilizado quantas vezes forem necessárias dentro do mesmo projeto, sem duplicação de código.

Além disso, módulos suportam os mesmos mecanismos de controle de execução dos recursos Terraform, incluindo:

* `depends_on`
* `count`
* `for_each`
* `providers`

Isso permite construir infraestruturas complexas de forma organizada, previsível e altamente reutilizável.

---

## Objetivos de Aprendizagem

Ao final deste material você será capaz de:

* Reutilizar um módulo diversas vezes.
* Criar múltiplas instâncias de um módulo.
* Entender a independência entre instâncias de módulos.
* Utilizar `depends_on` em módulos.
* Controlar a ordem de execução entre módulos.
* Aplicar boas práticas de reutilização.

---

# Introdução

Após criar o módulo `pets`, passamos a ter uma estrutura semelhante a:

```text
terraform-project/
│
├── main.tf
│
└── modules/
    │
    └── pets/
        │
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

Agora existe uma "caixa preta" responsável por:

* Criar nomes aleatórios.
* Criar arquivos.
* Expor resultados.

Uma vez criada essa caixa preta, podemos utilizá-la inúmeras vezes.

---

# Reutilizando um Módulo

## Primeira Instância

```hcl
module "pets01" {

  source = "./modules/pets"

  prefixo_arquivo = "Arquivo 01"

}
```

---

## Segunda Instância

```hcl
module "pets02" {

  source = "./modules/pets"

  prefixo_arquivo = "Arquivo 02"

}
```

---

## O Que Mudou?

Observe que:

```hcl
source = "./modules/pets"
```

permanece exatamente igual.

O que muda são apenas os parâmetros enviados.

---

# Fluxo de Execução

```text
                 ┌──────────────┐
                 │ Módulo Pets  │
                 └──────┬───────┘
                        │
        ┌───────────────┼───────────────┐
        │                               │
        ▼                               ▼

 module.pets01                 module.pets02

 Arquivo 01                    Arquivo 02
```

O mesmo módulo é utilizado duas vezes.

---

# Quantos Recursos Serão Criados?

Lembrando que o módulo possui:

```text
2 random_pet
2 local_file
```

Ou seja:

```text
4 recursos
```

---

## Utilizando o Módulo Uma Vez

```text
module.pets01
```

Resultado:

```text
4 recursos
```

---

## Utilizando Duas Vezes

```text
module.pets01
module.pets02
```

Resultado:

```text
8 recursos
```

---

# Estrutura Gerada

Terraform cria internamente algo semelhante a:

```text
module.pets01.random_pet.pet1

module.pets01.random_pet.pet2

module.pets01.local_file.file1

module.pets01.local_file.file2
```

e também:

```text
module.pets02.random_pet.pet1

module.pets02.random_pet.pet2

module.pets02.local_file.file1

module.pets02.local_file.file2
```

---

# Benefícios da Reutilização

Sem módulos:

```hcl
resource ...
resource ...
resource ...
resource ...
```

Duplicado diversas vezes.

---

Com módulos:

```hcl
module "pets01" {

}
```

```hcl
module "pets02" {

}
```

---

Resultado:

```text
✔ Menos código
✔ Menos manutenção
✔ Mais organização
✔ Maior produtividade
```

---

# Analogia com Programação

Sem reutilização:

```csharp
CriarArquivo();
CriarArquivo();
CriarArquivo();
CriarArquivo();
```

Repetindo implementação.

---

Com reutilização:

```csharp
CriarArquivo("Arquivo 01");

CriarArquivo("Arquivo 02");
```

Mesmo código.

Parâmetros diferentes.

---

# Dependências Entre Módulos

Além da reutilização, podemos controlar a ordem de execução dos módulos.

Para isso utilizamos:

```hcl
depends_on
```

---

# Por Que Utilizar Depends On?

Imagine o seguinte cenário:

```text
Módulo Banco de Dados
        │
        ▼
Módulo Aplicação
```

A aplicação depende do banco.

Não faz sentido criar a aplicação antes.

---

# Exemplo Conceitual

```text
Database Module
        │
        ▼
Application Module
```

---

Terraform precisa saber dessa dependência.

---

# Depends On em Módulos

Exemplo:

```hcl
module "application" {

  source = "./modules/application"

  depends_on = [
    module.database
  ]

}
```

---

## Significado

```text
Crie o módulo database primeiro.
Somente depois crie application.
```

---

# Aplicando ao Exemplo Pets

Suponha:

```hcl
module "pets01" {

}
```

e

```hcl
module "pets02" {

}
```

Queremos que:

```text
pets02
   ↓
pets01
```

---

## Configuração

```hcl
module "pets01" {

  source = "./modules/pets"

  depends_on = [
    module.pets02
  ]

}
```

---

# Fluxo Sem Depends On

```text
Terraform
     │
     ├── pets01
     │
     └── pets02
```

Terraform decide a ordem.

Pode executar em paralelo.

---

# Fluxo Com Depends On

```text
Terraform
     │
     ▼
pets02
     │
     ▼
pets01
```

A ordem fica explícita.

---

# Processo de Criação

## Sem Dependência

```text
terraform apply
      │
      ▼
Criação paralela
```

---

## Com Dependência

```text
terraform apply
      │
      ▼
Cria pets02
      │
      ▼
Finaliza pets02
      │
      ▼
Cria pets01
```

---

# Processo de Destruição

O comportamento também afeta o destroy.

---

## Criação

```text
pets02
     ↓
pets01
```

---

## Destruição

```text
pets01
     ↓
pets02
```

Terraform respeita a dependência inversamente.

---

# Quando Utilizar Depends On?

Utilize quando houver dependência real.

---

## Exemplos

### Banco de Dados

```text
Banco
 ↓
Aplicação
```

---

### Rede

```text
VPC
 ↓
Subnets
 ↓
Instâncias
```

---

### Kubernetes

```text
Cluster
 ↓
Namespaces
 ↓
Aplicações
```

---

# Quando Não Utilizar?

Evite criar dependências artificiais.

---

## Errado

```hcl
depends_on = [
  module.random_module
]
```

Sem necessidade.

---

Isso reduz paralelismo e aumenta tempo de execução.

---

# Boas Práticas

## Utilize módulos para eliminar duplicação

Correto:

```hcl
module "pets01" {

}
```

```hcl
module "pets02" {

}
```

---

Evite:

```hcl
resource ...
resource ...
resource ...
```

copiados várias vezes.

---

## Parametrize cada instância

Exemplo:

```hcl
prefixo_arquivo = "DEV"
```

```hcl
prefixo_arquivo = "HML"
```

```hcl
prefixo_arquivo = "PROD"
```

---

## Utilize depends_on apenas quando necessário

Apenas para dependências reais.

---

## Prefira módulos pequenos

Módulos menores são:

* Mais reutilizáveis
* Mais testáveis
* Mais fáceis de documentar

---

# Fluxo Completo do Exemplo

```text
Root Module
     │
     ├──────────────┐
     │              │
     ▼              ▼

module.pets02   module.pets01
                     ▲
                     │
              depends_on
                     │
                     └──── module.pets02
```

---

# Resumo

Neste capítulo aprendemos que um módulo pode ser reutilizado inúmeras vezes dentro do mesmo projeto.

Exemplo:

```hcl
module "pets01" {

  source = "./modules/pets"

}
```

```hcl
module "pets02" {

  source = "./modules/pets"

}
```

Cada instância cria sua própria infraestrutura de forma independente.

Também aprendemos a controlar a ordem de execução utilizando:

```hcl
depends_on
```

Exemplo:

```hcl
depends_on = [
  module.pets02
]
```

Com isso o Terraform garante que:

```text
pets02
   ↓
pets01
```

seja executado na ordem correta.

Esses conceitos são fundamentais para construir arquiteturas modulares, reutilizáveis e escaláveis em projetos Terraform de médio e grande porte.

---

# Distribuição de Terraform Modules com Terraform Registry

## Visão Geral

Criar um módulo reutilizável é apenas parte do processo.

Para que o módulo possa ser utilizado por outras pessoas, equipes ou até mesmo por você em outros projetos e máquinas, é necessário disponibilizá-lo em algum local acessível.

O Terraform suporta diversas formas de distribuição de módulos:

* Terraform Registry
* GitHub
* GitLab
* Bitbucket
* Repositórios Git privados
* Amazon S3
* Google Cloud Storage (GCS)
* Azure Storage
* Sistemas internos da empresa

Neste capítulo vamos focar na principal solução utilizada pela comunidade Terraform:

O **Terraform Registry**.

---

## Objetivos de Aprendizagem

Ao final deste material você será capaz de:

* Entender o propósito da distribuição de módulos.
* Publicar módulos no Terraform Registry.
* Utilizar versionamento semântico.
* Criar releases utilizando Git Tags.
* Consumir módulos publicados.
* Documentar módulos adequadamente.
* Disponibilizar exemplos de utilização.

---

# Introdução

Até agora criamos módulos locais.

Exemplo:

```hcl
module "wordpress" {

  source = "./modules/wp_stack"

}
```

Esse modelo funciona bem para testes e pequenos projetos.

Entretanto possui algumas limitações:

* Funciona apenas na máquina local.
* Não facilita colaboração.
* Não permite versionamento centralizado.
* Não facilita compartilhamento.

Para resolver isso publicamos o módulo em um repositório.

---

# O Problema dos Módulos Locais

Estrutura típica:

```text
terraform-project/
│
├── main.tf
│
└── modules/
    └── wp_stack/
```

O módulo existe apenas dentro desse projeto.

---

## Limitações

```text
❌ Difícil compartilhar
❌ Difícil reutilizar
❌ Difícil controlar versões
❌ Dependência da estrutura local
```

---

# O Que é o Terraform Registry?

O Terraform Registry é o catálogo oficial de módulos e providers do Terraform.

Ele permite:

* Publicar módulos.
* Versionar módulos.
* Compartilhar módulos.
* Descobrir módulos da comunidade.
* Centralizar documentação.

---

## Benefícios

```text
✅ Distribuição centralizada
✅ Versionamento
✅ Documentação automática
✅ Integração com GitHub
✅ Fácil consumo
```

---

# Pré-requisitos

Antes de publicar um módulo você precisa possuir:

## Conta GitHub

Será utilizada para armazenar o código.

---

## Conta Terraform Registry

Cadastro gratuito.

A autenticação é feita utilizando:

```text
Sign In with GitHub
```

---

# Fluxo de Publicação

```text
Terraform Module
        │
        ▼
GitHub Repository
        │
        ▼
Git Tag
        │
        ▼
Terraform Registry
        │
        ▼
Disponível para Consumo
```

---

# Convenção de Nomeação

O Terraform Registry exige um padrão específico.

Formato:

```text
terraform-<provider>-<nome>
```

---

## Exemplo

Provider:

```text
DigitalOcean
```

Nome:

```text
wordpress-do
```

Resultado:

```text
terraform-digitalocean-wordpress-do
```

---

# Criando o Repositório

No GitHub:

```text
New Repository
```

Nome:

```text
terraform-digitalocean-wordpress-do
```

Visibilidade:

```text
Public
```

---

# Estrutura Inicial do Módulo

Exemplo:

```text
terraform-digitalocean-wordpress-do/
│
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

# Inicializando o Git

Dentro da pasta do módulo:

```bash
git init
```

---

Adicionar arquivos:

```bash
git add .
```

---

Criar commit:

```bash
git commit -m "commit inicial"
```

---

# Associando ao GitHub

Adicionar repositório remoto:

```bash
git remote add origin <repositorio>
```

---

Definir branch principal:

```bash
git branch -M main
```

---

Enviar código:

```bash
git push -u origin main
```

---

# Publicando no Terraform Registry

Após subir o código:

1. Acesse o Terraform Registry.
2. Clique em Publish.
3. Autorize acesso ao GitHub.
4. Selecione o repositório.

---

## Problema Comum

Mesmo após subir o código, o módulo ainda não aparece disponível.

Motivo:

```text
Não existe versão publicada.
```

---

# Versionamento Semântico

O Terraform Registry exige versões.

Utilizamos:

```text
MAJOR.MINOR.PATCH
```

---

## Exemplos

```text
v1.0.0
v1.0.1
v1.1.0
v2.0.0
```

---

# Criando uma Tag

Exemplo:

```bash
git tag v1.0.0
```

---

Enviar tags:

```bash
git push --tags
```

---

# Fluxo de Versionamento

```text
Commit
   │
   ▼
Tag
   │
   ▼
Registry
   │
   ▼
Nova Versão Disponível
```

---

# Publicação Bem-Sucedida

Após criar a tag:

```text
v1.0.0
```

O Registry detecta automaticamente a nova versão.

---

## Resultado

```text
Terraform Registry
   └── v1.0.0
```

---

# Consumindo o Módulo Publicado

Antes:

```hcl
module "wordpress" {

  source = "./modules/wp_stack"

}
```

---

Depois:

```hcl
module "wordpress" {

  source = "usuario/wordpress-do/digitalocean"

}
```

---

# O Que Mudou?

Antes:

```text
Módulo Local
```

Agora:

```text
Módulo Remoto
```

---

# Fluxo de Consumo

```text
terraform init
      │
      ▼
Terraform Registry
      │
      ▼
Download do Módulo
      │
      ▼
Execução
```

---

# Terraform Init com Registry

Ao executar:

```bash
terraform init
```

Terraform:

1. Localiza o módulo.
2. Faz download.
3. Armazena localmente.
4. Inicializa o projeto.

---

# Versionando Melhorias

Imagine que você adicionou:

```text
README
Exemplos
Correções
Novos recursos
```

---

Novo commit:

```bash
git add .
git commit -m "adicionando readme"
```

---

Nova versão:

```bash
git tag v1.0.1
```

---

Publicação:

```bash
git push
git push --tags
```

---

Resultado:

```text
v1.0.1
```

Disponível automaticamente.

---

# Documentação do Módulo

Uma boa documentação é essencial.

Crie:

```text
README.md
```

---

## Exemplo

```markdown
# WordPress DigitalOcean Module

Módulo responsável por provisionar uma stack WordPress na DigitalOcean utilizando Terraform.
```

---

# O Que o Registry Faz Automaticamente?

Ele interpreta:

* Variáveis
* Outputs
* Exemplos
* README

E gera documentação visual.

---

# Inputs

São as variáveis do módulo.

Exemplo:

```hcl
variable "region" {

  type = string

}
```

---

O Registry exibe automaticamente:

```text
Inputs
```

com nome, tipo e descrição.

---

# Outputs

Exemplo:

```hcl
output "ip_publico" {

  value = digitalocean_droplet.wp.ipv4_address

}
```

---

O Registry gera automaticamente:

```text
Outputs
```

---

# Adicionando Exemplos

Estrutura recomendada:

```text
examples/
│
└── simple/
    ├── main.tf
    └── README.md
```

---

# Exemplo Simples

```hcl
module "wordpress" {

  source = "usuario/wordpress-do/digitalocean"

}
```

---

# Por Que Criar Exemplos?

Benefícios:

```text
✅ Facilita adoção
✅ Facilita aprendizado
✅ Reduz dúvidas
✅ Serve como documentação viva
```

---

# Estrutura Profissional de Módulo

```text
terraform-digitalocean-wordpress-do/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
├── LICENSE
│
└── examples/
    └── simple/
        ├── main.tf
        └── README.md
```

---

# Boas Práticas

## Utilize Versionamento Semântico

Correto:

```text
v1.0.0
v1.0.1
v1.1.0
```

---

## Nunca Altere uma Versão Existente

Errado:

```text
Editar código mantendo v1.0.0
```

Correto:

```text
Criar nova versão
```

---

## Sempre Documente

Inclua:

* Objetivo
* Inputs
* Outputs
* Exemplos

---

## Disponibilize Exemplos

```text
examples/simple
examples/production
examples/high-availability
```

---

## Mantenha README Atualizado

Documentação desatualizada gera erros de utilização.

---

# Fluxo Completo de Publicação

```text
Criar Módulo
      │
      ▼
Criar Repositório GitHub
      │
      ▼
Subir Código
      │
      ▼
Criar Tag
      │
      ▼
Publicar Registry
      │
      ▼
Disponibilizar Documentação
      │
      ▼
Disponibilizar Exemplos
      │
      ▼
Consumir via Terraform Init
```

---

# Resumo

Neste capítulo aprendemos como transformar um módulo local em um módulo distribuível utilizando o Terraform Registry.

Principais etapas:

1. Criar repositório GitHub.
2. Seguir o padrão de nomenclatura:

```text
terraform-<provider>-<nome>
```

3. Subir o código.
4. Criar tags:

```bash
git tag v1.0.0
git push --tags
```

5. Publicar no Terraform Registry.
6. Documentar com README.
7. Criar exemplos de utilização.

O Terraform Registry é a principal forma de distribuição de módulos Terraform e permite criar componentes reutilizáveis, versionados e compartilháveis, elevando significativamente a qualidade e maturidade dos projetos de Infraestrutura como Código (IaC).
