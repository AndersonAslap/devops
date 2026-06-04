resource "local_file" "foo" {
  content  = "O valor que eu irei utilizar de máquina é ${var.conteudo_tuple[0]} - ${var.conteudo_tuple[1]} - ${var.conteudo_tuple[2]}"
  filename = "./arquivo.txt"
}

/*
resource "local_file" "foo" {
  content  = "O valor que eu irei utilizar de máquina é ${var.conteudo_object.machine}"
  filename = "./arquivo.txt"
}
*/

/*
resource "local_file" "foo" {
  content  = "O valor que eu irei utilizar de máquina é ${join(", ", var.conteudo_set)}"
  filename = "./arquivo.txt"
}
*/

/*
resource "local_file" "foo" {
  content  = "O valor que eu irei utilizar de máquina é ${var.conteudo_map["small"]}"
  filename = "./arquivo.txt"
}
*/

/*
resource "local_file" "foo" {
  content  = "O valor que eu irei utilizar de máquina é ${var.conteudo_list[0]}"
  filename = "./arquivo.txt"
}
*/

variable "conteudo" {
  default     = "Conteúdo do arquivo"
  type        = string
  description = "conteúdo que vai para o arquivo"
}

variable "conteudo_number" {
  default     = 1
  type        = number
  description = "conteúdo que vai para o arquivo"
}

variable "conteudo_bool" {
  default     = false
  type        = bool
  description = "conteúdo que vai para o arquivo"
}

variable "conteudo_list" {
  default     = ["vm-01", "vm-02", "vm-03"]
  type        = list(string)
  description = "conteúdo que vai para o arquivo"
}

variable "conteudo_map" {
  default = {
    "small"  = "s-1vcpu-2gb"
    "medium" = "s-2vcpu-4gb"
    "large"  = "s-4vcpu-8gb"
  }
  type        = map(string)
  description = "conteúdo que vai para o arquivo"
}

variable "conteudo_set" {
  default     = ["vm-01", "vm-02", "vm-03"]
  type        = set(string)
  description = "conteúdo que vai para o arquivo"
}

variable "conteudo_object" {
  default = {
    region  = "NYC1",
    machine = "VM-01"
    bkp     = false
  }
  type = object({
    region  = string,
    machine = string,
    bkp     = bool
  })
  description = "conteúdo que vai para o arquivo"
}

variable "conteudo_tuple" {
  default = ["NYC1", "VM-01", false]
  type        = tuple([string, string, bool])
  description = "conteúdo que vai para o arquivo"
}