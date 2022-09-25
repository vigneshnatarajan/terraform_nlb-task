variable "nlb_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "subnet_list" {
  description = "Name to be used on all the resources as identifier"
  type        = list(string)
  default     = ""
}

variable "tcp_udp_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "udp_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tcp_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tls_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}
