locals {
  address = "${google_compute_address.db_internal_ip.address}"
}

resource "google_compute_instance" "db" {
    name            = "${var.name}"
    machine_type    = "g1-small"
    zone            = "${var.zone}"
    tags            = ["reddit-db"]
    boot_disk {
        initialize_params {
            image = "${var.db_disk_image}"
        }
    }
    network_interface {
        network = "default"

        access_config {
        // Ephemeral IP
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

    #provisioner "remote-exec" {
    #inline = [
    #  "sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf",
    #  "sudo systemctl restart mongod",
    #]
  #}

}
resource "google_compute_address" "db_internal_ip" {
  name         = "${var.name}-internal-ip"
  address_type = "INTERNAL"
}

resource "google_compute_firewall" "firewall_mongo" {
    name = "${var.name}-allow-mongo-default"
    network = "default"
    allow {
        protocol = "tcp"
        ports = ["27017"]
    }
    target_tags = ["reddit-db"]
    source_tags = ["reddit-app"]
}