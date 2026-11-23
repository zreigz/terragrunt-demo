resource "local_file" "storage" {
  filename = "${path.module}/storage.txt"
  content  = "storage"
}
