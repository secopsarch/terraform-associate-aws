output "aws_s3_bucket" {
  description = "name of the bucket"
  value       = aws_s3_bucket.bucket.arn
}
output "aws_s3_bucket_id" {
  value = aws_s3_bucket.bucket.id
}
output "ec2_id" {
  value = module.ec2_instance[*].id
}

output "ec2_public_ip" {
  value = module.ec2_instance[*].public_ip
}

output "ec2_private_ip" {
  value = module.ec2_instance[*].private_ip
}
