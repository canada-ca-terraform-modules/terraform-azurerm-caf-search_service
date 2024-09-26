variable "SearchService" {
  type = any
  description = "Object that will contain all parameters for Search Service"
  default = {}
}

variable "tags" {
  description = "Maps of tags that will be applied to the resource"
  type = map(string)
  default = {}
}

variable "env" {
  description = "(Required) Env value for the name of the resource"
  type = string
}

variable "group" {
  description = "(Required) Group value for the name of the resource"
  type = string
}

variable "project" {
  description = "(Required) Project value for the name of the resource"
  type = string
}

variable "userDefinedString" {
  description = "(Required) UserDefinedString value for the name of the resource"
  type = string
}

variable "location" {
  description = "Azure location for the resource"
  type = string
  default = "canadacentral"
}

variable "resource_groups" {
  description = "Resouce group object containing a list of resource group in the target project"
  type = any
  default = null
}

variable "private_dns_zone_ids" {
  description = "Object containing private DNS zone IDs for the target project"
  type = any
  default = {}
}

variable "subnets" {
  description = "Subnet object containing a list of subnets in the target project"
  type = any
  default = null
}