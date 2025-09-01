variable "key_name" {
  type = string
}

variable "cloudflare_account_id" {
  type      = string
  sensitive = true
}

variable "domain1name" {
  type = string
}

variable "domain2name" {
  type = string
}

variable "webserver_name" {
  type = string
}