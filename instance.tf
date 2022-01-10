resource "google_service_account" "default" {
  project      = "projecto-demo-337817"
  account_id   = "service-account-id"
  display_name = "Service Account"
}
resource "google_project_iam_member" "project" {
  project = "projecto-demo-337817"
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.default.email}"
}
resource "google_compute_network" "vpc_network" {
  project                 = "projecto-demo-337817"
  name                    = "new-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "new_subnetwork" {
  project       = "projecto-demo-337817"
  name          = "new-network-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.self_link
  secondary_ip_range {
    range_name    = "second-network-subnetwork"
    ip_cidr_range = "10.10.1.0/24"
  }
  depends_on = [
    google_compute_network.vpc_network
  ]
}

resource "google_compute_firewall" "demo_fw" {
  project       = "projecto-demo-337817"
  name    = "demo-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080", "1000-2000"]
  }
  #source_ranges = ["35.235.240.0/20", "177.245.144.0/22", "200.79.180.4/32"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
  project       = "projecto-demo-337817"
  name         = "demo-instance-ubuntu"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.new_subnetwork.name
    access_config {
    }
  }
  metadata = {
    startup-script = file("${path.module}/startup.sh")
  }
}