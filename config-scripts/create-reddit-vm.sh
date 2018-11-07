#!/bin/bash

gcloud compute instances create reddit-full --zone=europe-west1-b --image "reddit-full-1540329152" --machine-type f1-micro

gcloud compute instances start reddit-full --zone=europe-west1-b
gcloud compute instances stop reddit-full --zone=europe-west1-b
