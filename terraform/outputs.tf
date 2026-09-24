output "file_path" {
  description = "Path to the generated Acme test file"
  value       = local_file.acme_test.filename
}