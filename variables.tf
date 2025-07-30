##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------
variable "custom_name" {
  type        = string
  default     = null
  description = "Override default naming convention"
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.

- If true, the keyword is prepended: "vnet-core-dev".
- If false, the keyword is appended: "core-dev-vnet".

This helps maintain naming consistency based on organizational preferences.
EOT
}

##-----------------------------------------------------------------------------
## Labels
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azure-data-factory"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", "location"]
  description = "The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']."
}


##-----------------------------------------------------------------------------
## Global Variables
##-----------------------------------------------------------------------------
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

##-----------------------------------------------------------------------------
## Data Factory
##-----------------------------------------------------------------------------
variable "public_network_enabled" {
  type        = bool
  default     = false
  description = "Enable public network access for Data Factory."
}

variable "managed_virtual_network_enabled" {
  type        = bool
  default     = null
  description = "Enable managed virtual network for Data Factory."
}

variable "identity_type" {
  description = "Type of Managed Service Identity. Options: SystemAssigned, UserAssigned, or both."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = null
}

variable "key_vault_id" {
  type        = string
  default     = null
  description = "Key Vault ID for encryption keys."
}

variable "principal_id" {
  type        = list(string)
  default     = []
  description = "Principal IDs (User, Group, or Service Principal) for role assignment."
}

variable "cmk_encryption_enabled" {
  type        = bool
  default     = false
  description = "Enable Customer Managed Key encryption."
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = true
  description = "Enable Shared Access Key authentication for storage account."
}

variable "github_configuration" {
  type = object({
    account_name    = string
    branch_name     = string
    git_url         = string
    repository_name = string
    root_folder     = string
  })
  default     = null
  description = "GitHub integration configuration."
}

variable "vsts_configuration" {
  type = object({
    account_name    = string
    branch_name     = string
    project_name    = string
    repository_name = string
    root_folder     = string
    tenant_id       = string
  })
  default     = null
  description = "Azure DevOps (VSTS) integration configuration."
}

variable "global_parameters" {
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default     = null
  description = "List of global parameters for Data Factory."
}