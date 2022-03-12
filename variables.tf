variable "name" {
  default     = "test"
  description = "Name of SA and VM"
  type        = string
}

variable "machine_type" {
  default     = "e2-medium"
  description = "Type of VM"
  type        = string
}

variable "project_id" {
  default     = "aleksandrov-gatech-test"
  description = "Project ID"
  type        = string
}

variable "zone" {
  default     = "europe-west4-a"
  description = "Zone name"
  type        = string
}

variable "region" {
  default     = "europe-west4"
  description = "Zone name"
  type        = string
}

variable "vpc_name" {
  default     = "vpc-network"
  description = "VPC name"
  type        = string
}

variable "ip_cidr_range" {
  description = "Range of IPs in the subnet (ex. 10.0.0.0/22)"
  type        = string
}

variable "roles" {
  type        = list(string)
  description = "List of roles"
  default     = []
}