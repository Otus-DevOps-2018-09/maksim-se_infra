variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for provisioners"
}
variable name {
  description = "Resource name, e.g.: reddit-app"
  default     = "reddit-app"
}

variable tags {
  default     = "reddit-app"
}


variable zone {
  description = "Zone"
  default     = "us-central1-a"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}
variable "app_db_ip" {
  description = "Environment DATABASE_URL"
}