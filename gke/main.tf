resource "google_compute_network" "vpc_network" {
  name                    = "gke-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "gke-subnet"
  network       = google_compute_network.vpc_network.id
  region        = var.region
  ip_cidr_range = "10.10.0.0/16"
}

resource "google_container_cluster" "primary" {
  name       = var.cluster_name
  location   = var.region
  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.gke_subnet.id

  enable_autopilot    = true
  deletion_protection = false
}