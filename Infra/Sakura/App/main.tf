terraform {
  required_providers {
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "2.33.0"
    }
  }
}

provider "sakuracloud" {}

variable "user" {
  type = object({
    name     = string
    password = string
  })
}

variable "registry" {
  type = object({
    image  = string
    server = string
  })
}

resource "sakuracloud_apprun_application" "swift-server" {
  name            = "swift-server"
  timeout_seconds = 10
  port            = 8080
  min_scale       = 0
  max_scale       = 1
  components {
    name       = "playground"
    max_cpu    = "0.5"
    max_memory = "1Gi"
    deploy_source {
      container_registry {
        image    = var.registry.image
        server   = var.registry.server
        username = var.user.name
        password = var.user.password
      }
    }
  }
}