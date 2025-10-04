output "subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.this.id
}
