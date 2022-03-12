resource "google_compute_firewall" "ssh" {
  name    = "${var.name}-firewall-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.name}-firewall-ssh"]
  source_ranges = var.fw_source_range
}

resource "google_compute_firewall" "http" {
  name    = "${var.name}-firewall-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["${var.name}-firewall-http"]
  source_ranges = var.fw_source_range
}

resource "google_compute_firewall" "https" {
  name    = "${var.name}-firewall-https"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags   = ["${var.name}-firewall-https"]
  source_ranges = var.fw_source_range
}