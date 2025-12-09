terraform {
  required_providers {
    sakuracloud = {
      source = "sacloud/sakuracloud"
      version = "2.33.0"
    }
  }
}

provider "sakuracloud" {}

variable user {
  type = object({
    name       = string
    password   = string
    permission = string
  })
}

resource "sakuracloud_container_registry" "swift_app_run" {
  name            = "swift-app-run"
  access_level    = "readwrite"
  subdomain_label = "swift-app-run"

  user {
    name = var.user.name
    password = var.user.password
    permission = var.user.permission
  }
}
