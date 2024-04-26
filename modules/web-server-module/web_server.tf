locals {
  instance_startup_script = file("${path.module}/instance_startup_script.sh")
}

// allow http traffic to default network
resource "google_compute_firewall" "nginx" {
  name    = "nginx-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

// create compute instance
resource "google_compute_instance" "tf-instance" {
  name         = "tf-instance"
  machine_type = "e2-micro"

  // create Debian boot disk
  boot_disk {
    device_name = "tf-instance-boot-disk"
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  // attach default network
  network_interface {
    network = "default"
    access_config {
      // ephemeral external IP
    }
  }

  // startup script
  metadata_startup_script = local.instance_startup_script
}

// output instance ip
output "tf_instance_ip" {
  value       = google_compute_instance.tf-instance.network_interface.0.access_config.0.nat_ip
  description = "Instance IP address for connection"
  sensitive   = false
}
