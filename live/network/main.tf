resource "local_file" "network" {
  filename = "${path.module}/network.txt"
  content  = "network"
}

output "name" {
  value = "network"
}
