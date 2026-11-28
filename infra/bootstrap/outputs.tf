output "state_bucket" {
  description = "Put this in each environment's backend block."
  value       = aws_s3_bucket.state.bucket
}
