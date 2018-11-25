provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

locals {
  app_name  = "reddit-app-${var.env}"
  db_name   = "reddit-dn-${local.env}"
  vpc_name  = "reddit-vpc-${local.env}"
}

module "app" {
  source          = "../modules/app"
  name            = "${local.app_name}"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  app_db_ip       = "${module.db.db_internal_ip}"
  tags            = "${local.app_name}"
}

module "db" {
  source          = "../modules/db"
  name            = "${local.db_name}"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
  tags            = "${local.app_name}"
}

module "vpc" {
  source        = "../modules/vpc"
  name          = "${local.vpc_name}"
  source_ranges = ["${var.source_ip}"]
}
