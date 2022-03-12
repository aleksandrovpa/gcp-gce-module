resource "random_id" "sa_id" {
  keepers = {
    ami_id = var.name
  }

  byte_length = 5
}

# data "google_iam_role" "role_permissions" {
#   for_each = toset(var.roles)
#   name     = each.value
# }

resource "google_service_account" "service_account" {
  account_id   = "${var.name}-${random_id.sa_id.hex}"
  display_name = var.name
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-${var.name}"
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_instance" "gce" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link

    # access_config {
    #   // Ephemeral public IP
    # }
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.service_account.email
    scopes = ["cloud-platform"]
  }
}