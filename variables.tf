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
  default     = "your-project-name"
  description = "Project ID"
  type        = string
}

variable "zone" {
  default     = "europe-west4-a"
  description = "Zone name (https://cloud.google.com/compute/docs/regions-zones#available)"
  type        = string
}

variable "region" {
  default     = "europe-west4"
  description = "Region name (https://cloud.google.com/compute/docs/regions-zones#available)"
  type        = string
}

variable "vpc_name" {
  default     = "vpc-network"
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  default     = "default"
  description = "Subnet name"
  type        = string
}

variable "ip_cidr_range" {
  description = "Range of IPs in the subnet (ex. 10.0.0.0/22)"
  type        = string
}

variable "fw_source_range" {
  description = "Range of IPs wich will be allow in firewall"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "roles" {
  type        = list(string)
  description = "List of roles wich could be found here https://cloud.google.com/iam/docs/permissions-reference"
  default     = ["roles/editor"]
}