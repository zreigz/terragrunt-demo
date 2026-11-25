variable "network_name" {
  type = string
}

resource "local_file" "app" {
  filename = "${path.module}/app.txt"
  # The approval policy matches this content on app.local_file.app.
  content  = "run-all demo depends on ${var.network_name}"
}
