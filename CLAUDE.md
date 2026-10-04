# CLAUDE.md

Este arquivo orienta o Claude Code (claude.ai/code) ao trabalhar com o código deste repositório.

## Natureza do repositório

Anotações pessoais de estudo de DevOps (escritas em português do Brasil) e pequenos exercícios práticos. Não há sistema de build, lint ou testes na raiz. Escreva novas anotações em português e siga o estilo de arquivos numerados já existente (`01-...md`, `02-...md`).

## Estrutura

- `IaC/terraform/` — anotações teóricas numeradas (`01-` … `06-*.md`) junto com o código dos hands-on:
  - `hands-on-01`, `-02`, `-03`: raízes Terraform independentes (cada uma com `providers.tf`, `variables.tf`, `main.tf`, `outputs.tf`; a 01 e a 02 também têm `datasources.tf` e `terraform.tfvars`). O provider é a DigitalOcean, com o token passado por `var.digitalocean_token`.
  - `mod-09-terraform-modules/v1` e `v2`: a v1 usa recursos declarados diretamente; a v2 consome um módulo publicado em registry privado (`app.terraform.io/aslap-digital/wp-do/digitalocean`).
  - Cada diretório é uma raiz Terraform própria, então execute os comandos dentro do diretório específico: `terraform init && terraform plan` (ou `terraform validate` / `terraform fmt`). Alguns arquivos têm caminhos do Windows fixos (ex.: a chave pública SSH em `v2/main.tf`); ajuste-os para rodar localmente.
- `containers/docker/` — pastas de tópicos numeradas (`00-docs` … `09-ambiente-seguro`), cada uma com um `resumo.md`. `@shared/app` é um app Express minúsculo (`npm install`, `node index.js`) reutilizado pelos exemplos de Docker; `02-imagem/dockefile` (assim mesmo, com o erro de grafia) contém o Dockerfile de exemplo.
- `containers/kubernetes/` — `01-primeiros-passos` (manifestos de pod, replicaset, deployment e service) e `02-gerenciamento-de-configuracao` (env, configmap, secrets). Aplique com `kubectl apply -f <arquivo>`. `comandos.md` é uma cola de comandos.
- `projetos/app-variaveis-ambiente/` — um **repositório git aninhado**, com `.git` próprio e um workflow do GitHub Actions (`.github/workflows/main.yml`). Faça commits dele de dentro desse diretório, não da raiz.
- `prompts/` — prompts reutilizáveis (ex.: transformar transcrições de aula em material didático).
- `comandos-sistema-operacional/`, `observabilidade/`, `cloud/`, `IA-para-devops/` — em sua maioria anotações/readmes, alguns ainda vazios ou não rastreados.

## Observações

- O state do Terraform e `.terraform/` são ignorados via `IaC/terraform/.gitignore`; nunca faça commit de `terraform.tfstate` ou de tokens reais. Os `*.tfvars` estão no gitignore, mas alguns foram commitados antes da regra existir, então mantenha segredos fora deles.
