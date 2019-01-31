variable "source_ranges" {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}

variable name {
  description = "Resource name, e.g.: reddit-vpc"
  default     = "reddit-vpc"
}
