terraform {
    backend "gcs" {
    bucket = "sb-stage"
    prefix = "terraform/stage"
}
}