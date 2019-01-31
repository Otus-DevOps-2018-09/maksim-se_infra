resource "google_compute_instance_group" "reddit-app" {
    name            = "reddit-app"
    description     = "приложение reddit instance group"

    instances       = [
        "${google_compute_instance.app.*.self_link}",
        #"${google_compute_instance.app-2.*.self_link}"
        ]

    named_port {
        name    = "http9292"
        port    =  "9292"
    }

    zone        = "${var.zone}"    
}

resource "google_compute_health_check" "app_health" {
    name                = "app-health"
    check_interval_sec  = 10
    timeout_sec         = 10

    tcp_health_check {
        port    = "9292"
    }
}

resource "google_compute_backend_service" "app_backend" {
    name                = "app-backend"
    description         = "бакэнд прилодения"

    protocol            = "HTTP"
    port_name           = "http9292"
    timeout_sec         = "10"

    backend {
        group = "${google_compute_instance_group.reddit-app.self_link}"
    }

    health_checks = ["${google_compute_health_check.app_health.self_link}"]
}

resource "google_compute_url_map" "app_url_maps" {
    name                = "app-url-maps"
    default_service     = "${google_compute_backend_service.app_backend.self_link}"
}

resource "google_compute_target_http_proxy" "app_proxy" {
  name                  = "app-proxy"
  url_map               = "${google_compute_url_map.app_url_maps.self_link}"
}

resource "google_compute_global_forwarding_rule" "app_url_rule" {
  name                  = "app-url-rule"
  target                = "${google_compute_target_http_proxy.app_proxy.self_link}"
  port_range            = "80"
}
