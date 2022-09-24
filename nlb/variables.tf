variable "nlb_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "Demo-NLB"
}

variable "vpc_id" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "vpc-0e36e57ebebe775b1"
}

variable "subnet_list" {
  description = "Name to be used on all the resources as identifier"
  type        = list(string)
  default     = ["subnet-0900c416d4f8c2c48","subnet-08288bd327f34a8b5"]
}

variable "tcp_udp_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "tcp-udp-tg"
}

variable "udp_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "udp-tg"
}

variable "tcp_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "tcp-tg"
}

variable "tls_tg" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "tls-tg"
}
