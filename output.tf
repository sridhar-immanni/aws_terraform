output "ELB" {
  value = aws_alb.my-elb.dns_name
}

output "instance" {
  value = aws_instance.instancef.public_ip
}

output "rds" {
  value = aws_db_instance.mysql.endpoint
}