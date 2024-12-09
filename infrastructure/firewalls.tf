resource "google_compute_firewall" "allow_ssh" {
  name = "allow-ssh"
  network = google_compute_network.main-vpc.name

  allow {
    protocol = "tcp"
    ports = [ "22" ]
  }

  source_ranges = ["0.0.0.0/0"]
}