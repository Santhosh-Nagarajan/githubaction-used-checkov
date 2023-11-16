resource "google_compute_instance" "default" {
  name         = var.instance-name
  machine_type = var.machine-type
  zone         = var.zone


  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      size   = var.size
      image  = var.image-name
      labels = var.labels
    }
    kms_key_self_link = "key-link"

  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true

  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }

  metadata = {
    block-project-ssh-keys = true
  }


  metadata_startup_script = "echo hi > /test.txt"


  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    email  = "[PROJECT_NUMBER]-compute@developer.gserviceaccount.com"
  }







}

# Create HTTP firewall rule
resource "google_compute_firewall" "http_firewall" {
  name    = "http-firewall"
  network = google_compute_instance.default.network_interface

  allow {
    protocol = "tcp"
    ports    = ["80,443"]
  }

  source_ranges = var.firewal-source-range
}

# Create SSH firewall rule
resource "google_compute_firewall" "ssh_firewall" {
  name    = "ssh-firewall"
  network = google_compute_instance.default.id

  allow {
    protocol = "tcp"
    ports    = ["22, ${var.port}"]
  }

  source_ranges = var.firewall-ssh-source-range
}
