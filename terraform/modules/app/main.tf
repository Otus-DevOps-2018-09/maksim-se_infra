resource "google_compute_instance" "app" {
  name         = "${var.name}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

#  provisioner "file" {
#    source      = "../modules/app/files/puma.service"
#    destination = "/tmp/puma.service"
#  }
#  provisioner "remote-exec" {
#    inline = [
#      "echo 'export DATABASE_URL=${var.app_db_ip}' > /home/appuser/.bash_profile",
#      "chown appuser:appuser /home/appuser/.bash_profile"
#    ]
#  }
#  provisioner "remote-exec" {
#    script = "../modules/app/files/deploy.sh"
#}
}

resource "google_compute_address" "app_ip" {
  name = "${var.name}-reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "${var.name}-allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
