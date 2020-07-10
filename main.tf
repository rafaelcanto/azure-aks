provider "azurerm" {
  features {}
  version = "~> 2.0"
}


locals {
  rg_name          = "rg-${var.project_name}-${var.environment_type}-01"             // rg-projeto-dev-01
  rg_nodepool_name = "rg-${var.project_name}-${var.environment_type}-01-nodepool-01" // rg-projeto-dev-01-nodepool-01
  aks_name         = "aks-${var.project_name}-${var.environment_type}-01"            // aks-projeto-dev-01
  node_pool_name   = "pool01"
  aks_dns_prefix   = "aks-dns-${var.project_name}-${var.environment_type}-01-dns" // akscluster-dev-01

  tags = {
    environment_type            = var.environment_type
    sigla                       = var.tag_sigla
    descsigla                   = var.tag_descsigla
    pep                         = var.tag_pep
    project                     = var.tag_project
    golive                      = var.tag_golive
    backup                      = var.tag_backup
    function                    = var.tag_function
    service                     = var.tag_service
    owner                       = var.tag_owner
    scheduledstartstop          = var.tag_scheduledstartstop
    office_hours                = var.tag_office_hours
    office_days                 = var.tag_office_days
    scheduledstartstopexception = var.tag_scheduledstartstopexception
    hardening                   = var.tag_hardening
    region                      = var.location
  }
}

resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_resource_group" "nodepool" {
  name     = local.rg_nodepool_name
  location = var.location
  tags     = local.tags
}


resource "azurerm_kubernetes_cluster" "main" {
  name                = local.aks_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = local.aks_dns_prefix
  node_resource_group = azurerm_resource_group.nodepool.name

  default_node_pool {
    name           = local.node_pool_name
    node_count     = var.node_count
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  # service_principal {
  #   client_id     = "${var.kubernetes_client_id}"
  #   client_secret = "${var.kubernetes_client_secret}"
  # }

  tags = local.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "main" {
  name                  = local.node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  node_count            = var.node_count
  vm_size               = "Standard_D2_v2"
  vnet_subnet_id        = var.subnet_id

  tags = local.tags
}

