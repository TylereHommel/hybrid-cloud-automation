output "file_path" {
  description = "Path to the generated Acme test file"
  value       = local_file.acme_test.filename
}

output "web_server_file" {
  description = "Path to the simulated Acme web server"
  value       = local_file.web_server.filename
}

output "database_server_file" {
  description = "Path to the simulated Acme database server"
  value       = local_file.database_server.filename
}