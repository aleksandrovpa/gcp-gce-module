resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_address" "external_ip" {
  name         = "external-ip-${var.name}"
  subnetwork   = google_compute_subnetwork.subnet.id
  address_type = "EXTERNAL"
  region       = var.region
}
