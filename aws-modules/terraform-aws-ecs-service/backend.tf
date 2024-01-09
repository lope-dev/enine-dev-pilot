terraform {
  cloud {
    organization = "Ahead"

    workspaces {
      name = "terraform-demo-ecs-service-module"
    }
  }
}
