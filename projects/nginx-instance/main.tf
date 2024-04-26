terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.26.0"
    }
  }

  required_version = ">=1.8.2"
}


module "web-server-module" {
  source = "../../modules/web-server-module"
}

output "instance-ip" {
  value = module.web-server-module.tf_instance_ip
}