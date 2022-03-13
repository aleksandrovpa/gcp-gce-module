# gcp-gce-module
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.external_ip](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/compute_address) | resource |
| [google_compute_firewall.http](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.https](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.ssh](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/compute_firewall) | resource |
| [google_compute_instance.gce](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/compute_instance) | resource |
| [google_compute_network.vpc_network](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/compute_subnetwork) | resource |
| [google_project_iam_member.iam_role](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/project_iam_member) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/service_account) | resource |
| [google_service_account_key.service_account_key](https://registry.terraform.io/providers/hashicorp/google/4.13.0/docs/resources/service_account_key) | resource |
| [random_id.sa_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fw_source_range"></a> [fw\_source\_range](#input\_fw\_source\_range) | Range of IPs wich will be allow in firewall | `list(string)` | <pre>[<br>  "10.0.0.0/24",<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_ip_cidr_range"></a> [ip\_cidr\_range](#input\_ip\_cidr\_range) | Range of IPs in the subnet (ex. 10.0.0.0/22) | `string` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Type of VM (https://cloud.google.com/compute/vm-instance-pricing) | `string` | `"e2-medium"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of SA and VM | `string` | `"test"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | `"your-project-name"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region name (https://cloud.google.com/compute/docs/regions-zones#available) | `string` | `"europe-west4"` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | List of roles wich could be found here https://cloud.google.com/iam/docs/permissions-reference | `list(string)` | <pre>[<br>  "roles/editor"<br>]</pre> | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnet name | `string` | `"default"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC name | `string` | `"vpc-network"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone name (https://cloud.google.com/compute/docs/regions-zones#available) | `string` | `"europe-west4-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gce_external_ip"></a> [gce\_external\_ip](#output\_gce\_external\_ip) | n/a |
| <a name="output_service_account_key"></a> [service\_account\_key](#output\_service\_account\_key) | n/a |
<!-- END_TF_DOCS -->

## Example:

```
provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.13.0"
    }
  }
  required_version = ">= 1.1.5"
}

module "test" {
  source = "../gcp-gce-module"

  name            = "test"
  machine_type    = "e2-medium"
  ip_cidr_range   = "10.0.0.0/22"
  fw_source_range = ["192.168.1.0/24"]
  project_id      = "your_project-name"
  region          = var.region
  roles           = ["roles/editor"]
  vpc_name        = "test-vpc"
  subnet_name     = "test-subnet"
  zone            = "europe-west4-a"
}

output "test_ip" {
  value = module.test.gce_external_ip
}

output "test_sa_key" {
  value = module.test.service_account_key
}
```