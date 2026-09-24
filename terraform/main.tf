resource "local_file" "acme_test" {
  content  = var.message
  filename = "${path.module}/hello.txt"
}

resource "local_file" "web_server" {
  content  = "Acme Web Server\nEnvironment: development\nManaged by: Terraform\n"
  filename = "${path.module}/web-server.txt"
}

resource "local_file" "database_server" {
  content  = "Acme Database Server\nEnvironment: development\nManaged by: Terraform\n"
  filename = "${path.module}/database-server.txt"
}