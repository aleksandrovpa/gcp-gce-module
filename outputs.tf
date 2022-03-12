output "service_account_key" {
  value = nonsensitive(sha256(google_service_account_key.service_account_key.private_key))
}

output "gce_external_ip" {
  value = google_compute_address.external_ip.address
}