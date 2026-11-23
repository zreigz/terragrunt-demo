variable "network_name" {
  type = string
}

resource "local_file" "app" {
  filename = "${path.module}/app.txt"
  # Change this string to make a follow-up plan touch only this unit.
  content  = "app depends on ${var.network_name}"
}
