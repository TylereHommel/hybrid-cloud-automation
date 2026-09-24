resource "local_file" "acme_test" {
  content  = var.message
  filename = "${path.module}/hello.txt"
}