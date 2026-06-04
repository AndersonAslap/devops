# Funções e Expressões no Terraform

## Visão Geral

O Terraform possui um conjunto robusto de funções e expressões que permitem manipular dados, realizar cálculos, validar entradas, transformar valores e construir lógicas mais sofisticadas dentro dos arquivos `.tf`.

Esses recursos tornam o código mais:

* Reutilizável
* Dinâmico
* Legível
* Seguro
* Flexível

Embora não seja possível criar funções personalizadas no Terraform, a ferramenta já disponibiliza centenas de funções prontas para uso.

---

## Objetivos de Aprendizagem

Ao final deste material você será capaz de:

* Entender o que são funções no Terraform.
* Utilizar funções numéricas.
* Utilizar funções de manipulação de strings.
* Ler arquivos utilizando funções do sistema.
* Compreender expressões aritméticas e lógicas.
* Criar expressões condicionais.
* Utilizar laços de repetição em expressões.
* Utilizar o Terraform Console para testes.
* Implementar validações em variáveis.
* Aplicar boas práticas na manipulação de dados.

---

# Introdução

Durante a construção de infraestrutura como código, frequentemente precisamos:

* Manipular strings
* Validar entradas
* Calcular valores
* Processar listas
* Construir condições
* Ler arquivos externos

Para resolver esses cenários, o Terraform oferece:

```text
Funções
+
Expressões
=
Infraestrutura Dinâmica
```

---

# Conceitos Fundamentais

## Funções

Funções são recursos internos do Terraform que recebem parâmetros e retornam um resultado.

### Exemplo

```hcl
max(10, 20, 30)
```

Resultado:

```text
30
```

---

## Expressões

Expressões são combinações de valores, operadores e funções que produzem um resultado final.

### Exemplo

```hcl
50 + 10
```

Resultado:

```text
60
```

---

# Categorias de Funções do Terraform

O Terraform disponibiliza funções para diversas finalidades:

| Categoria       | Finalidade                    |
| --------------- | ----------------------------- |
| Numeric         | Operações numéricas           |
| String          | Manipulação de texto          |
| Collection      | Manipulação de listas e mapas |
| Filesystem      | Leitura de arquivos           |
| Encoding        | Conversões de formato         |
| Date and Time   | Datas e horários              |
| Hash and Crypto | Hashes e criptografia         |

---

# Funções Numéricas

## max()

Retorna o maior valor da lista.

### Exemplo

```hcl
max(54, 23, 19, 20)
```

Resultado:

```text
54
```

---

### Aplicação Prática

```hcl
resource "local_file" "exemplo" {

  content  = max(54, 23, 19, 20)

  filename = "arquivo.txt"

}
```

Resultado:

```text
54
```

---

## min()

Retorna o menor valor da lista.

### Exemplo

```hcl
min(54, 23, 19, 20)
```

Resultado:

```text
19
```

---

### Fluxo

```text
Lista
 ↓
min()
 ↓
Menor valor
```

---

# Funções de String

## startswith()

Verifica se uma string inicia com determinado texto.

### Sintaxe

```hcl
startswith("Hello World", "Hello")
```

Resultado:

```text
true
```

---

### Exemplo Negativo

```hcl
startswith("Hello World", "hello")
```

Resultado:

```text
false
```

---

### Importante

A comparação é:

```text
Case Sensitive
```

Ou seja:

```text
Hello ≠ hello
```

---

## endswith()

Verifica se uma string termina com determinado texto.

### Exemplo

```hcl
endswith("Hello World", "World")
```

Resultado:

```text
true
```

---

### Exemplo Negativo

```hcl
endswith("Hello World", "Hello")
```

Resultado:

```text
false
```

---

# Manipulação de Coleções

## join()

Une elementos de uma lista em uma única string.

### Sintaxe

```hcl
join(", ", [
  "Docker",
  "Kubernetes",
  "Prometheus"
])
```

Resultado:

```text
Docker, Kubernetes, Prometheus
```

---

## Fluxo

```text
Lista
 │
 ├── Docker
 ├── Kubernetes
 └── Prometheus
      │
      ▼
join(", ")
      │
      ▼
Docker, Kubernetes, Prometheus
```

---

# Conversão de Texto

## upper()

Converte uma string para maiúsculo.

### Exemplo

```hcl
upper("docker")
```

Resultado:

```text
DOCKER
```

---

## lower()

Converte uma string para minúsculo.

### Exemplo

```hcl
lower("DOCKER")
```

Resultado:

```text
docker
```

---

## Combinando Funções

Uma das maiores vantagens do Terraform é combinar funções.

### Exemplo

```hcl
upper(
  join(", ", [
    "Docker",
    "Kubernetes",
    "Prometheus"
  ])
)
```

Resultado:

```text
DOCKER, KUBERNETES, PROMETHEUS
```

---

# Limpeza de Strings

## trimspace()

Remove espaços no início e no final da string.

### Exemplo

```hcl
trimspace("      Docker      ")
```

Resultado:

```text
Docker
```

---

## Antes

```text
"      Docker      "
```

## Depois

```text
"Docker"
```

---

## Atenção

O `trimspace()` remove apenas:

```text
✓ Espaços iniciais
✓ Espaços finais
```

Não remove espaços internos.

---

### Exemplo

Entrada:

```text
" Docker Kubernetes "
```

Saída:

```text
"Docker Kubernetes"
```

---

# Funções de Sistema de Arquivos

## file()

Lê o conteúdo de um arquivo.

### Exemplo

```hcl
file("~/.ssh/id_rsa.pub")
```

Resultado:

```text
ssh-rsa AAAA...
```

---

## Quando Utilizar

* Chaves SSH
* Scripts Shell
* Templates
* Certificados
* Arquivos de configuração

---

## Fluxo

```text
Arquivo Local
      │
      ▼
file()
      │
      ▼
Conteúdo do Arquivo
```

---

# Expressões no Terraform

## O Que São

Expressões são valores processados que retornam um resultado.

---

# Expressões Aritméticas

## Soma

```hcl
50 + 10
```

Resultado:

```text
60
```

---

## Subtração

```hcl
50 - 10
```

Resultado:

```text
40
```

---

## Multiplicação

```hcl
50 * 40
```

Resultado:

```text
2000
```

---

## Divisão

```hcl
50 / 40
```

Resultado:

```text
1.25
```

---

## Utilizando Variáveis

```hcl
variable "valor" {

  default = 40

}
```

```hcl
50 + 10 + var.valor
```

Resultado:

```text
100
```

---

# Expressões Lógicas

Permitem realizar comparações.

### Exemplo

```hcl
var.valor == 10
```

Resultado:

```text
true
```

ou

```text
false
```

---

## Operadores Mais Utilizados

| Operador | Significado    |
| -------- | -------------- |
| ==       | Igual          |
| !=       | Diferente      |
| >        | Maior          |
| <        | Menor          |
| >=       | Maior ou igual |
| <=       | Menor ou igual |

---

# Expressões Condicionais

Funcionam como um operador ternário.

### Sintaxe

```hcl
condicao ? valor_se_verdadeiro : valor_se_falso
```

---

## Exemplo

```hcl
var.valor > 10 ? "maior" : "menor"
```

Resultado:

```text
maior
```

ou

```text
menor
```

---

## Fluxo

```text
           valor > 10?
               │
      ┌────────┴────────┐
      │                 │
    Sim               Não
      │                 │
      ▼                 ▼
 "maior"           "menor"
```

---

# Expressões de Repetição

Terraform permite percorrer listas usando expressões `for`.

---

## Exemplo

```hcl
[
  for v in var.valor :
  upper(v)
]
```

---

### O Que Está Acontecendo

```text
Lista Original
    │
    ▼
Docker
Jenkins
Terraform
    │
    ▼
upper()
    │
    ▼
DOCKER
JENKINS
TERRAFORM
```

---

## Exemplo Completo

```hcl
join(", ", [

  for v in var.valor :

  upper(trimspace(v))

])
```

---

### Resultado

```text
DOCKER, JENKINS, TERRAFORM
```

---

# Terraform Console

## O Que É

Ferramenta interativa para testar:

* Funções
* Expressões
* Variáveis
* Estruturas condicionais

Sem precisar executar um `terraform apply`.

---

## Iniciando

```bash
terraform console
```

---

## Exemplo

```hcl
> upper("docker")
```

Resultado:

```text
DOCKER
```

---

## Testando Variáveis

```hcl
> var.valor
```

Resultado:

```text
[
  "Docker",
  "Jenkins",
  "Terraform"
]
```

---

## Testando Join

```hcl
> join(", ", var.valor)
```

Resultado:

```text
Docker, Jenkins, Terraform
```

---

## Benefícios

```text
✓ Desenvolvimento mais rápido
✓ Debug facilitado
✓ Testes instantâneos
✓ Menos terraform apply
```

---

# Validação de Variáveis

## O Problema

Usuários podem fornecer valores inválidos.

Exemplos:

```text
Quantidade negativa de VMs
Região inválida
Lista incompleta
Valor fora do padrão
```

---

## Solução

Terraform possui:

```hcl
validation
```

---

## Exemplo

```hcl
variable "valor" {

  validation {

    condition = contains(
      var.valor,
      "Kubernetes"
    )

    error_message = "A lista deve conter Kubernetes."

  }

}
```

---

## Funcionamento

```text
Lista
 │
 ▼
contains()
 │
 ▼
true ?
 │
 ├── Sim → Continua
 │
 └── Não → Erro
```

---

## Resultado de Erro

```text
Invalid value for variable

A lista deve conter Kubernetes.
```

---

# Casos Reais de Validação

## Quantidade de Máquinas Virtuais

```hcl
variable "vm_count" {

  validation {

    condition = var.vm_count > 0

    error_message = "A quantidade de VMs deve ser maior que zero."

  }

}
```

---

## Ambiente Permitido

```hcl
variable "environment" {

  validation {

    condition = contains(
      ["dev", "homolog", "prod"],
      var.environment
    )

    error_message = "Ambiente inválido."

  }

}
```

---

## Região Permitida

```hcl
variable "region" {

  validation {

    condition = contains(
      ["us-east-1", "us-west-2"],
      var.region
    )

    error_message = "Região não suportada."

  }

}
```

---

# Boas Práticas

## Utilize Validações Sempre que Possível

Evita erros antes do provisionamento.

---

## Teste Expressões no Terraform Console

Antes de aplicar:

```bash
terraform console
```

---

## Combine Funções

Exemplo:

```hcl
upper(
  trimspace(
    var.nome
  )
)
```

---

## Evite Hardcode

Prefira:

```hcl
var.region
```

ao invés de:

```hcl
"us-east-1"
```

---

# Resumo

Funções e expressões são recursos fundamentais do Terraform para criar infraestruturas inteligentes e dinâmicas.

Os principais conceitos estudados foram:

* `max()`
* `min()`
* `startswith()`
* `endswith()`
* `join()`
* `upper()`
* `lower()`
* `trimspace()`
* `file()`
* Expressões aritméticas
* Expressões lógicas
* Expressões condicionais
* Laços com `for`
* `terraform console`
* `validation`

O domínio desses recursos permite escrever códigos Terraform mais robustos, reutilizáveis e preparados para ambientes reais de produção.
