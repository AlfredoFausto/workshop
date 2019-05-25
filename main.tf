
provider "digitalocean" {
    token = "${var.myToken}"
}
resource "digitalocean_droplet" "nginx_droplet" {
  image  = "ubuntu-18-04-x64"
  name   = "nginx-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
}