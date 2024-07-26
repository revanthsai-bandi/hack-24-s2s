provider "google" {
  project = "lloyds-hack-grp-24"
  region  = var.region
  zone = var.zone
}

resource "google_compute_instance" "default" {
  name         = "${var.instance_name}-${formatdate("YYYYMMDDhhmmss",timestamp())}"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.boot_image
    }
  }

  tags = ["http-server","https-server","tt-allow-internet-access","tt-allow-jenkins"]

  metadata = {
    startup-script-url = var.startup-script-url
  }

  network_interface {
    network = "default"
    access_config {}
  }

    service_account {
    		email  = "sa-cloud-build@lloyds-hack-grp-24.iam.gserviceaccount.com"
    		scopes = ["cloud-platform"]
  	}

  lifecycle {
    create_before_destroy = true
  }

}

resource "google_storage_bucket_object" "picture" {
  name   = "tfcodes2s/DataSpeak-mains2s.zip"
  source = "/var/lib/jenkins/workspace/hack-24/code-deployment-scm/DataSpeak-mains2s.zip"
  bucket = "ai-alchemist"
}
