variable "environment" {
  type = string
}

variable "region" {
  type = string

  validation {
    condition = contains(["East US","West Europe","Southeast Asia"], var.region)
    error_message = "Invalid region"
  }
}

variable "prefix" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_app" {
  type = string
}

variable "subnet_mgmt" {
  type = string
}

variable "instance_count" {
  type = number
}