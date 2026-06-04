

## Terraform

`Provisionamento de Infraestrutura`

- Declara os elementos da infraestrutura
- Está relacionado a criação de recursos

## Ansible

`Gerenciamento de Configuração`

- Configura os elemento da infraestrutura
- Está relacionado a configuração de recursos

---

`Repositório de providers do terraform`

- https://registry.terraform.io/

`comandos`

```bash
terraform init

terraform fmt

terraform validate

terraform plan

terraform apply

terraform apply --auto-approve

terraform output

terraform destroy

terraform apply -var-file=<pathfile>

terraform apply -var="conteudo_string=Teste de variável com passagem por comando" -var='lista_nomes=["maquina01", "maquina02"]'
```

ordem de prioridade de passagem de variável

O que tem peso leve e é desprezável primeiro 
é variável de ambiente.

O que tem peso médio é pelo arquivo 
terraform.tfvars ele tem prioridade acima
do que variáveis de ambiente.

O que tem peso maior sobre os outros é a passagem
de variável através da linha de comando, ele sobreescreve 
os passo anteriores.

---

Resource ele representa um elemento de infraestrutura que iremos 
criar no cloud provider e no resource tem como dar uma enriquecida nele
inserindo meta argumentos que nada mais é do que recurso para dar um up na 
infraestrutura e facilicar a criação dos recursos.

---

### Meta Argumentos

`depends_on`

utilizar o depend-on para criar uma dependência caso não existe uma dependência implícita nos recursos

`count`

você pode utilizar um count para criar uma estrutura de repetição

`for_each`

para criar os seus recursos e pode utilizar também o for it para criar uma estrutura também de repetição, só que utilizando valores de um set ou de um map.
