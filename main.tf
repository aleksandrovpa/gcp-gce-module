resource "random_id" "sa_id" {
  keepers = {
    ami_id = var.name
  }

  byte_length = 5
}

resource "google_project_iam_member" "iam_role" {
  for_each = toset(var.roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_service_account" "service_account" {
  account_id   = "${var.name}-${random_id.sa_id.hex}"
  display_name = var.name
}

resource "google_service_account_key" "service_account_key" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}


resource "google_compute_instance" "gce" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9" # https://cloud.google.com/compute/docs/images/os-details
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link

    access_config {
      nat_ip = google_compute_address.external_ip.address
    }
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.service_account.email
    scopes = ["cloud-platform"]
  }

  tags = [
    "${var.name}-firewall-ssh",
    "${var.name}-firewall-http",
    "${var.name}-firewall-https",
  ]
}