provider "azurerm" {
  features {}
  version = "~> 2.0"
}


locals {
  rg_name        = "rg-${var.project_name}-${var.environment_type}"
  aks_name       = "aks-${var.project_name}-${var.environment_type}-01"
  node_pool_name = "workers-01"

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


resource "azurerm_kubernetes_cluster" "main" {
  name                = local.aks_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.aks_prefix

  default_node_pool {
    name           = local.node_pool_name
    node_count     = var.node_count
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = var.subnet_id
  }

  service_principal {
    client_id     = "${var.kubernetes_client_id}"
    client_secret = "${var.kubernetes_client_secret}"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      client_app_id     = "${var.kubernetes_client_id}"
      server_app_id     = "${var.kubernetes_client_id}"
      server_app_secret = "${var.kubernetes_client_secret}"
    }
  }

  network_profile {
    network_plugin = "azure"
  }

  tags = local.tags
}

