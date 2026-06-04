# Terraform Provisioners

## Visão Geral

Provisioners são recursos do Terraform que permitem executar comandos, scripts ou transferir arquivos durante o processo de provisionamento da infraestrutura.

Eles são utilizados para realizar configurações adicionais em recursos recém-criados, como:

* Instalação de pacotes
* Configuração de serviços
* Execução de scripts
* Cópia de arquivos
* Inicialização de aplicações

Apesar de serem bastante úteis, os Provisioners devem ser utilizados apenas como último recurso, pois o Terraform não possui controle total sobre a execução dessas tarefas dentro do recurso provisionado.

---

## Objetivos de Aprendizagem

Ao final deste material você deverá ser capaz de:

* Entender o que são Provisioners no Terraform.
* Compreender por que eles devem ser utilizados com cautela.
* Diferenciar os tipos de Provisioners disponíveis.
* Utilizar Local Exec, Remote Exec e File.
* Configurar conexões SSH para execução remota.
* Entender alternativas mais adequadas para configuração de servidores.
* Aplicar boas práticas em projetos de Infraestrutura como Código (IaC).

---

# Introdução

Quando trabalhamos com Infraestrutura como Código (IaC), normalmente pensamos apenas na criação dos recursos:

* Máquinas virtuais
* Redes
* Firewalls
* Load Balancers
* Bancos de dados

Porém, criar a infraestrutura é apenas parte do processo.

Após criar uma máquina virtual, geralmente é necessário:

* Instalar softwares
* Configurar serviços
* Ajustar permissões
* Copiar arquivos
* Inicializar aplicações

É nesse cenário que entram os Provisioners do Terraform.

---

## O Problema

Imagine o seguinte fluxo:

```text
Terraform
    │
    ▼
Cria Máquina Virtual
    │
    ▼
Servidor vazio
    │
    ▼
Necessário instalar:
- Docker
- Nginx
- Curl
- Aplicações
```

A máquina foi criada, mas ainda não está pronta para uso.

Precisamos executar tarefas adicionais.

---

# Por Que Evitar Provisioners?

Embora funcionem, Provisioners possuem algumas limitações importantes.

O Terraform é especializado em:

> Provisionar infraestrutura.

Ele não foi projetado para:

> Gerenciar configuração de servidores.

Por isso, quando utilizamos Provisioners, o Terraform perde parte da capacidade de controlar e monitorar o estado do ambiente.

---

## Possíveis Problemas

### Falhas de execução

Um comando pode falhar durante a instalação.

Exemplo:

```bash
apt install nginx -y
```

Caso haja problemas de rede ou repositório, a instalação pode falhar.

O Terraform pode não conseguir tratar adequadamente todos os cenários.

---

### Ambiente inconsistente

A máquina pode ser criada com sucesso, mas parte das configurações pode não ter sido aplicada.

Resultado:

```text
Infraestrutura criada ✓
Configuração aplicada ✗
```

---

# Alternativas Recomendadas

## AWS

A AWS oferece:

* User Data
* User Data Base64

Esses recursos permitem executar scripts durante a inicialização da instância EC2.

---

## Azure

O Azure oferece:

* Custom Data

Permite enviar scripts de configuração para a máquina virtual durante sua criação.

---

## Google Cloud Platform (GCP)

O GCP oferece:

* Metadata Startup Scripts

Scripts executados automaticamente na inicialização da VM.

---

## Melhor Alternativa: Ansible

A prática mais recomendada é combinar:

```text
Terraform
    │
    ▼
Provisiona infraestrutura
    │
    ▼
Ansible
    │
    ▼
Configura servidores
```

### Responsabilidades

| Ferramenta | Responsabilidade                  |
| ---------- | --------------------------------- |
| Terraform  | Provisionamento da infraestrutura |
| Ansible    | Configuração dos servidores       |
| Docker     | Empacotamento de aplicações       |
| Kubernetes | Orquestração                      |

---

# Tipos de Provisioners

O Terraform disponibiliza três tipos principais:

| Provisioner | Função                        |
| ----------- | ----------------------------- |
| Local Exec  | Executa comandos localmente   |
| Remote Exec | Executa comandos remotamente  |
| File        | Copia arquivos para o recurso |

---

# Local Exec

## O Que É

Executa comandos na máquina local que está executando o Terraform.

Não executa dentro da máquina criada.

---

## Fluxo de Funcionamento

```text
Terraform Apply
      │
      ▼
Cria VM
      │
      ▼
Executa comando local
```

---

## Exemplo

```hcl
resource "digitalocean_droplet" "vm" {

  provisioner "local-exec" {

    command = "echo Máquina criada com IP ${self.ipv4_address}"

  }

}
```

---

## Explicação

### self

Representa o próprio recurso.

```hcl
self.ipv4_address
```

Obtém o endereço IP da VM criada.

---

### command

Define o comando que será executado localmente.

```hcl
command = "echo Máquina criada"
```

---

## Saída Esperada

```bash
Máquina criada com IP 192.168.0.10
```

---

## Quando Utilizar

Situações como:

* Registrar logs
* Notificar sistemas externos
* Atualizar inventários
* Executar scripts locais

---

# Remote Exec

## O Que É

Executa comandos diretamente dentro da máquina criada.

Para isso é necessário:

* Acesso SSH
* Usuário válido
* Chave privada

---

## Fluxo de Funcionamento

```text
Terraform
    │
    ▼
Cria VM
    │
    ▼
Conecta via SSH
    │
    ▼
Executa comandos
```

---

# Configurando a Connection

Antes de usar o Remote Exec é necessário definir a conexão.

## Exemplo

```hcl
connection {

  type = "ssh"

  user = "root"

  private_key = file("~/.ssh/terraform")

  host = self.ipv4_address

}
```

---

## Explicação dos Campos

| Campo       | Descrição         |
| ----------- | ----------------- |
| type        | Tipo de conexão   |
| user        | Usuário remoto    |
| private_key | Chave privada SSH |
| host        | Endereço da VM    |

---

# Executando Comandos Remotamente

## Exemplo

```hcl
provisioner "remote-exec" {

  inline = [

    "apt update",

    "apt install curl -y",

    "apt install nginx -y",

    "curl -fsSL https://get.docker.com | sh"

  ]

}
```

---

## O Que Está Acontecendo

### Atualização dos repositórios

```bash
apt update
```

Atualiza a lista de pacotes disponíveis.

---

### Instalação do Curl

```bash
apt install curl -y
```

Instala o Curl.

---

### Instalação do Nginx

```bash
apt install nginx -y
```

Instala o servidor web Nginx.

---

### Instalação do Docker

```bash
curl -fsSL https://get.docker.com | sh
```

Baixa e executa o script oficial de instalação do Docker.

---

## Resultado Final

Servidor configurado com:

```text
✓ Curl
✓ Nginx
✓ Docker
```

---

# File Provisioner

## O Que É

Permite copiar arquivos da máquina local para o servidor remoto.

---

## Fluxo de Funcionamento

```text
Arquivo Local
      │
      ▼
Provisioner File
      │
      ▼
Servidor Remoto
```

---

## Exemplo

```hcl
provisioner "file" {

  source = "instalacao.sh"

  destination = "/root/instalacao.sh"

}
```

---

## Explicação

### source

Arquivo existente localmente.

```hcl
source = "instalacao.sh"
```

---

### destination

Destino no servidor remoto.

```hcl
destination = "/root/instalacao.sh"
```

---

# Combinando File + Remote Exec

Uma prática comum é:

1. Copiar um script.
2. Alterar permissões.
3. Executar o script.

---

## Script Local

```bash
#!/bin/bash

apt update

apt install curl -y

apt install nginx -y

curl -fsSL https://get.docker.com | sh
```

---

## Executando o Script

```hcl
provisioner "remote-exec" {

  inline = [

    "chmod +x /root/instalacao.sh",

    "/root/instalacao.sh"

  ]

}
```

---

## Fluxo Completo

```text
Terraform
      │
      ▼
Cria VM
      │
      ▼
File Provisioner
      │
      ▼
Copia instalacao.sh
      │
      ▼
Remote Exec
      │
      ▼
chmod +x
      │
      ▼
Executa Script
      │
      ▼
Servidor Configurado
```

---

# Boas Práticas

## Prefira Recursos Nativos do Cloud Provider

Sempre que possível utilize:

* AWS User Data
* Azure Custom Data
* GCP Startup Scripts

---

## Utilize Ansible

Arquitetura recomendada:

```text
Terraform
      │
      ▼
Infraestrutura
      │
      ▼
Ansible
      │
      ▼
Configuração
      │
      ▼
Aplicação pronta
```

---

## Evite Scripts Complexos

Se o script estiver crescendo demais:

```text
10 linhas  -> aceitável
50 linhas  -> atenção
100+ linhas -> use Ansible
```

---

## Utilize Arquivos Externos

Prefira:

```hcl
provisioner "file"
```

em vez de grandes blocos:

```hcl
inline = [
  ...
]
```

Isso melhora:

* Organização
* Reuso
* Manutenção

---

# Erros Comuns

## Não Associar a Chave SSH

Sem chave válida:

```text
Connection failed
```

---

## Não Utilizar chmod

O arquivo é copiado mas não executa.

```bash
Permission denied
```

---

## Esquecer o -y no apt install

O processo fica aguardando interação.

```bash
apt install nginx
```

Correto:

```bash
apt install nginx -y
```

---

# Resumo

Provisioners permitem executar ações adicionais após a criação de recursos no Terraform.

Os três principais tipos são:

* Local Exec
* Remote Exec
* File

Apesar de úteis, eles devem ser utilizados apenas quando não houver alternativas melhores.

A arquitetura recomendada é:

```text
Terraform
    │
    ▼
Provisionamento
    │
    ▼
Ansible
    │
    ▼
Configuração
```

Essa abordagem proporciona maior confiabilidade, manutenção e escalabilidade para ambientes de infraestrutura modernos.
