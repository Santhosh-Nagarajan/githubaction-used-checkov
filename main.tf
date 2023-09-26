resource "google_compute_instance" "default" {
  name         = var.instance-name
  machine_type = var.machine-type
  zone         = var.zone

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      size  = var.size
      image = var.image-name
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network    = "default"
    access_config {}
  }
  metadata_startup_script = var.startup-script

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.email
    scopes = ["cloud-platform"]
  }
}

# Create HTTP firewall rule
resource "google_compute_firewall" "http_firewall" {
  name    = google_compute_instance.default.name
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Create SSH firewall rule
resource "google_compute_firewall" "ssh_firewall" {
  name    = "firewallname1"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}
