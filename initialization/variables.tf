# Input variables
variable "cidr_block" {
  description = "Provide CIDR value with /16 subnet from class A network"
  type        = string
  default     = "10.250.0.0/16"
}

variable "dns_support" {
  description = "Provide true/false to configure DNS for network, default: true"
  type        = bool
  default     = true
}

variable "dns_hostnames" {
  description = "Configure hostnames for resources in VPC network, default: true"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Set tags for VPC network"
  type        = map(string)
  default = {
    "Name"        = "TerraformDemo"
  }
}