<!-- BEGIN_TF_DOCS -->

# Terraform Azure Data Factory Module

This module provisions an **Azure Data Factory** instance with basic configurations. It is intended to be used as part of a modular Azure infrastructure deployment.

---

## 📋 Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.6.6  |
| Azurerm   | >= 3.116.0|

---

## 🔌 Providers

_No providers are explicitly defined in this example._

---

## 📦 Modules

| Name           | Source                                      | Version |
|----------------|---------------------------------------------|---------|
| resource_group | terraform-az-modules/resource-group/azure   | 1.0.0   |
| vnet           | terraform-az-modules/vnet/azure             | 1.0.0   |
| subnet         | terraform-az-modules/subnet/azure           | 1.0.0   |
| data_factory   | ./../../                                    | n/a     |


---


## 🏗️ Resources

_No standalone resources are declared in this example._

---

## 🔧 Inputs

_No input variables are defined in this example._

---

## 📤 Outputs

| Name                    | Description                                         |
|-------------------------|-----------------------------------------------------|
| data_factory_id         | The ID of the deployed Azure Data Factory.         |
| data_factory_identity   | The managed identity block of the Data Factory.    |

<!-- END_TF_DOCS -->
