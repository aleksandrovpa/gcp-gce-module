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
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.service_account.email
    scopes = ["cloud-platform"]
  }
}