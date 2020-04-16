

variable "project_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "environment_type" {
  type    = string
  default = "dev"
}

variable "subnet_id" {
  type    = string
  default = "/subscriptions/834f081d-bd7c-4908-97bd-98302a28f9fa/resourceGroups/rg-landingzone-nprd-network/providers/Microsoft.Network/virtualNetworks/vnet-landingzone-nprd-eastus2-01/subnets/snet-application"
}


variable "aks_prefix" {
  type = string
}

variable "node_count" {
  type    = number
  default = 1
}

// https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal
// az ad sp create-for-rbac --skip-assignment --name svc-aks-rbacs
variable "kubernetes_client_id" {
  type    = string
  default = "b2ceec84-df70-48cd-8f8c-62698e66340e"
}

variable "kubernetes_client_secret" {
  type    = string
  default = "=rrLl:i3?B-bH5fRWAs88j8fuQW3=CGE"
}






######################################################
##
##    TAGS
##
######################################################

variable "tag_sigla" {
  type        = string
  description = "Tag de negócios"
  default     = "CCoE"
}

variable "tag_descsigla" {
  type        = string
  description = "Tag de negócios (descsigla)"
  default     = "Cloud Team"
}

variable "tag_pep" {
  type        = string
  description = "id do PEP"
  default     = "P000000"
}


variable "tag_project" {
  type        = string
  description = "project startDate|endDate"
  default     = "02-04-2020|30-04-2020"
}


variable "tag_golive" {
  type    = bool
  default = false
}


variable "tag_backup" {
  type    = bool
  default = false

}

variable "tag_function" {
  type        = string
  description = "frontend|backend"
  default     = "backend"
}

variable "tag_service" {
  type        = string
  description = "web|webservice|queue|database|cache|streaming"
  default     = "database"
}

variable "tag_owner" {
  type        = string
  description = "dbas|performance|middlleware|telecom|devops|seginfo|monitoring"
  default     = "devops"
}

variable "tag_scheduledstartstop" {
  type    = bool
  default = false
}

variable "tag_office_hours" {
  type    = number
  default = 8
}

variable "tag_office_days" {
  type    = number
  default = 5
}

variable "tag_scheduledstartstopexception" {
  type    = bool
  default = false
}

variable "tag_hardening" {
  type    = string
  default = "empty"
}
