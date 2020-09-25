data "digitalocean_container_registry" "example" {
  name = "example"
}

resource "digitalocean_project_resources" "barfoo" {
  project = data.digitalocean_project.foo.id
  resources = [
    digitalocean_droplet.foobar.urn
  ]
}

resource "digitalocean_container_registry_docker_credentials" "example" {
  registry_name = "example"
}

resource "kubernetes_secret" "example" {
  metadata {
    name = "docker-cfg"
  }
  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.example.docker_credentials
  }
  type = "kubernetes.io/dockerconfigjson"
}