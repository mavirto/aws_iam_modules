# Variables para generar json policy, attach, role y assumerole

variable "crea_policy" {
  type = bool
}

variable "pol_nombre" {
  type = string
}

variable "pol_resources" {
  type = list(string)
}

variable "pol_actions" {
  type = list(string)
}

variable "role_name" {
  type = string
}
