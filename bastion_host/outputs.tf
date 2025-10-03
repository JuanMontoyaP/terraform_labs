output "bastion_host_public_ip" {
  description = "Public IP address of the bastion host"
  value       = aws_instance.bastion_host.public_ip
}

output "private_host_private_ip" {
  description = "Private IP address of the private host"
  value       = aws_instance.private_host.private_ip
}

output "ssh_key_file" {
  description = "Path to the SSH private key file"
  value       = local_file.private_key.filename
}

output "connection_instructions" {
  description = "Instructions for connecting to the instances"
  value       = <<-EOT
    To connect to the bastion host:
    ssh -i ${local_file.private_key.filename} ubuntu@${aws_instance.bastion_host.public_ip}
    
    Once on the bastion host, to connect to the private instance:
    ssh ubuntu@${aws_instance.private_host.private_ip}
    
    Note: The private key has been automatically installed on the bastion host at /home/ubuntu/.ssh/id_rsa
  EOT
}
